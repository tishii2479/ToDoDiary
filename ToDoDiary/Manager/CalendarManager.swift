//
//  CalendarManager.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/19.
//

import Foundation

class CalendarManager {
    static let shared = CalendarManager()
    
    var dayOffset: Int = 0
    
    // スクロールカウント
    // 無限スクロールに使う、上下に何回更新されたかを保持する
    // 上に更新されたら-1、下に更新されたら+1
    // 更新された分、日付をずらす処理をgetDateFromIndexで行う
    // CalendarViewModelに移すかもーーー
    var scrollCount: Int = 0
    
    init () {
        print("[debug] CalendarManager init")
        
        dayOffset = getDayOffset(date: Date())
    }
    
    // TODO: スクロールカウントを含めた処理
    func getDateFromIndex(index: Int) -> Date {
        guard let date = Calendar.current.date(byAdding: .day, value: index - dayOffset, to: Date()) else {
            print("[Error] GetDateFromIndex Failed")
            return Date()
        }
        
        return date
    }
    
    // カレンダー用の日付の文字列を返す
    // 1日ならば月を最初につける
    func formatDateForCalendar(date: Date) -> String {
        let comp = Calendar.current.dateComponents([.day], from: date)
        let formatter = DateFormatter()
        
        if comp.day == 1 {
            formatter.dateFormat = "M/d"
        } else {
            formatter.dateFormat = "d"
        }
        
        return formatter.string(from: date)
    }
    
    // 時間の表示
    func formatTime(date _date: Date?) -> String? {
        guard let date = _date else { return nil }
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "h:mm"
        
        return formatter.string(from: date)
    }
    
    // 全体のカレンダーの表示
    // dateがnilの場合は空文字列を返す
    func formatFullDate(date: Date?) -> String {
        guard let _date = date else { return "" }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "y/M/d (E)"
        
        return formatter.string(from: _date)
    }
    
    // カレンダー用に、月が奇数か偶数かを判断する
    func isOddMonth(date: Date) -> Bool {
        let comp = Calendar.current.dateComponents([.month], from: date)
        
        guard let month = comp.month else {
            print("[Error] IsOddMonth Failed")
            return false
        }
        
        return month % 2 == 1
    }
    
    // 曜日計算用のoffSetを計算する
    // 曜日(1...7) - 1を返す
    func getDayOffset(date: Date) -> Int {
        let comp = Calendar.current.dateComponents([.weekday], from: date)
        
        guard let offset = comp.weekday else {
            print("[Error] GetDayOffset Failed")
            return 0
        }
        
        return offset - 1
    }
}

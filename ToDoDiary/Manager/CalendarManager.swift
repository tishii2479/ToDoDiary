//
//  CalendarManager.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/19.
//

import Foundation

class CalendarManager {
    static let shared = CalendarManager()
    
    // スクロールカウント
    // 無限スクロールに使う、上下に何回更新されたかを保持する
    // 上に更新されたら-1、下に更新されたら+1
    // 更新された分、日付をずらす処理をgetDateFromIndexで行う
    var scrollCount = 0
    
    // TODO: スクロール更新後の調整
    func getDateFromIndex(index: Int) -> Date {
        if let date = Calendar.current.date(byAdding: .day, value: index, to: Date()) {
            return date
        }
        
        print("[Error] GetDateFromIndex Failed")
        return Date()
    }
    
    // カレンダー用の日付の文字列を返す
    // 1日ならば月を最初につける
    func formatForCalendar(date: Date) -> String {
        let comp = Calendar.current.dateComponents([.day], from: date)
        let formatter = DateFormatter()
        
        if comp.day == 1 {
            formatter.dateFormat = "M/d"
        } else {
            formatter.dateFormat = "d"
        }
        
        return formatter.string(from: date)
    }
    
    // カレンダー用に、月が奇数か偶数かを判断する
    func isOddMonth(date: Date) -> Bool {
        let comp = Calendar.current.dateComponents([.month], from: date)
        if let month = comp.month {
            return month % 2 == 1
        }
        
        print("[Error] IsOddMonth Failed")
        return false
    }
}

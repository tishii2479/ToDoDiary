//
//  CalendarManager.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/19.
//

import Foundation

class CalendarManager {
    static let shared = CalendarManager()
    
    // 曜日計算用のoffSetを計算する
    // 曜日(1...7) - 1を返す
    func getDayOffset(date: Date) -> Int {
        let comp = Calendar(identifier: .gregorian).dateComponents([.weekday], from: date)
        
        guard let offset = comp.weekday else {
            print("[Error] GetDayOffset Failed")
            return 0
        }
        
        return offset - 1
    }
    
    // 一年の最初の日を取得する
    func getStartOfMonth(year: Int, month: Int) -> Date {
        let comp = DateComponents(calendar: Calendar(identifier: .gregorian), year: year, month: month, day: 1)
        if let date = comp.date {
            return date
        }
        print("[error] failed to get start of year")
        return Date()
    }
    
    // 指定月の日数を得る
    func getLastDayOfMonth(year: Int, month: Int) -> Int {
        var comp = DateComponents()
        comp.year = year
        comp.month = month + 1
        comp.day = 0
        
        guard let date = Calendar(identifier: .gregorian).date(from: comp) else {
            print("[error] failed to get comp")
            return 30
        }
        
        return Calendar(identifier: .gregorian).component(.day, from: date)
    }
    
    // 一年の何日目かを取得する
    func getElapsedDays(from: Date, to: Date) -> Int {
        if let elapsedDays: Int = Calendar(identifier: .gregorian).dateComponents([.day], from: from, to: to).day {
            return elapsedDays
        }
        
        print("[error] failed to get elapsed days")
        return 0
    }
    
    // カレンダー用の日付の文字列を返す
    // 1日ならば月を最初につける
    func formatDateForCalendar(date: Date) -> String {
        let comp = Calendar(identifier: .gregorian).dateComponents([.day], from: date)
        let formatter = DateFormatter()
        
        if comp.day == 1 {
            formatter.dateFormat = "M/d"
        } else {
            formatter.dateFormat = "d"
        }
        
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
    
    // カレンダー用のタイトル
    func formatCalendarTitle(year: Int, month: Int) -> String {
        let components = DateComponents(calendar: Calendar(identifier: .gregorian), year: year, month: month)
        guard let date = components.date else {
            print("[Error] GetDateFromIndex Failed")
            return ""
        }
        
        return DateFormatter.format(date: date, format: "y/M")
    }
    
    // カレンダー用に、月が奇数か偶数かを判断する
    func isOddMonth(date: Date) -> Bool {
        let comp = Calendar(identifier: .gregorian).dateComponents([.month], from: date)
        
        guard let month = comp.month else {
            print("[Error] IsOddMonth Failed")
            return false
        }
        
        return month % 2 == 1
    }
    
    // ISSUE: 重いかも
    // 対象の日付が表示すべきかを返す
    func isTargetDate(date: Date, year: Int, month: Int) -> Bool {
        let comp = Calendar(identifier: .gregorian).dateComponents([.year, .month], from: date)
        guard let _year = comp.year, let _month = comp.month else {
            print("[error] earn components failed")
            return false
        }
        
        if year == _year && month == _month {
            return true
        } else {
            return false
        }
    }
}

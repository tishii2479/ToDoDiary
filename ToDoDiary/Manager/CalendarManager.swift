//
//  CalendarManager.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/19.
//

import Foundation

class CalendarManager {
    static let shared = CalendarManager()
    
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
    
    // カレンダー用に、月が奇数か偶数かを判断する
    func isOddMonth(date: Date) -> Bool {
        let comp = Calendar(identifier: .gregorian).dateComponents([.month], from: date)
        
        guard let month = comp.month else {
            print("[Error] IsOddMonth Failed")
            return false
        }
        
        return month % 2 == 1
    }
}

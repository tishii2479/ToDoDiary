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
    
    init () {
        print("[debug] CalendarManager init")
        
        dayOffset = getDayOffset(date: Date())
    }
    
    func getDateFromIndex(index: Int) -> Date {
        guard let date = Calendar.current.date(byAdding: .day, value: index + dayOffset, to: Date()) else {
            print("[Error] GetDateFromIndex Failed")
            return Date()
        }
        
        return date
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

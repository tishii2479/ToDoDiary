//
//  DateSelecterDirector.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/24.
//

import Foundation

class DateSelecterDirector: ObservableObject {
    // TODO: 初期値
    @Published var year: Int = 2021
    @Published var month: Int = 1
    @Published var offset: Int = 0
    
    // 日にち選択用に月の最初の曜日を取得する
    func getOffsetForDateSelecter(year: Int, month: Int) -> Int {
        let components = DateComponents(calendar: Calendar.current, year: year, month: month, day: 0)
        guard let date = components.date else {
            print("[Error] GetDayOffset Failed")
            return 0
        }
        
        let comp = Calendar.current.dateComponents([.weekday], from: date)
        
        guard let offset = comp.weekday else {
            print("[Error] GetDayOffset Failed")
            return 0
        }
        
        return offset - 1
    }
    
    // 日にち選択用に日だけ取得
    func formatDay(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "d"
        
        return formatter.string(from: date)
    }
    
    // year and date
    func title() -> String {
        let components = DateComponents(calendar: Calendar.current, year: year, month: month)
        guard let date = components.date else {
            print("[Error] GetDateFromIndex Failed")
            return ""
        }
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "y/M"
        
        return formatter.string(from: date)
    }
    
    // 日にち選択用の日付取得
    func getDateForDateSelecter(index: Int) -> Date {
        let components = DateComponents(calendar: Calendar.current, year: year, month: month, day: index - offset)
        guard let date = components.date else {
            print("[Error] GetDateFromIndex Failed")
            return Date()
        }
        
        return date
    }
    
    func selectDate(index: Int) {
        print(getDateForDateSelecter(index: index))
    }
    
    // 前の月
    func prevMonth() {
        month -= 1
        update()
    }
    
    // 次の月
    func nextMonth() {
        month += 1
        update()
    }
    
    // 選択している年、月が変わった時に呼ばれる
    func update() {
        offset = getOffsetForDateSelecter(year: year, month: month)
    }
}

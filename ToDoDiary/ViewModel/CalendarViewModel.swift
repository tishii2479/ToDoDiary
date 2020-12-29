//
//  CalendarViewModel.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var isShowingDetail: Bool = false
    @Published var selectedIndex: Int = 0
    @Published var selectedEventArray: [Event] = []
    @Published var nowIndex = 0
    
    // TODO: 初期値
    @Published var nowYear: Int = 2020
    @Published var dayOffset: Int = 0
    @Published var startOfYear: Date = Date()
    
    var today: Int = 0
    
    init() {
        update()
        today = getElapsedDays(from: startOfYear, to: Date())
    }
    
    func nextYear() {
        nowYear += 1
        update()
        today = 0
    }
    
    func lastYear() {
        nowYear -= 1
        update()
        today = 365
    }
    
    func update() {
        startOfYear = getStartOfYear(year: nowYear)
        dayOffset = getDayOffset(date: Calendar(identifier: .gregorian).startOfDay(for: startOfYear))
    }
    
    // カレンダーの日付選択時に呼ばれる
    func selectIndex(index: Int) {
        let selectedDate: Date = getDateFromIndex(index: index)
        
        let formatDate: String = CalendarManager.shared.formatFullDate(date: selectedDate)
        
        if let _selectedEventArray = EventManager.shared.getEventArrayFromDate(date: formatDate) {
            selectedEventArray = _selectedEventArray
        } else {
            selectedEventArray = []
        }
        
        isShowingDetail = true
        selectedIndex = index
    }
    
    // TODO: スクロールカウントを含めた処理
    func getDateFromIndex(index: Int) -> Date {
        guard let date = Calendar(identifier: .gregorian).date(byAdding: .day, value: index - dayOffset, to: startOfYear) else {
            print("[Error] GetDateFromIndex Failed")
            return Date()
        }
        
        return date
    }
    
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
    func getStartOfYear(year: Int) -> Date {
        let comp = DateComponents(calendar: Calendar(identifier: .gregorian), year: year, month: 1, day: 1)
        if let date = comp.date {
            return date
        }
        print("[error] failed to get start of year")
        return Date()
    }
    
    // 一年の何日目かを取得する
    func getElapsedDays(from: Date, to: Date) -> Int {
        if let elapsedDays: Int = Calendar(identifier: .gregorian).dateComponents([.day], from: from, to: to).day {
            return elapsedDays
        }
        
        print("[error] failed to get elapsed days")
        return 0
    }
}

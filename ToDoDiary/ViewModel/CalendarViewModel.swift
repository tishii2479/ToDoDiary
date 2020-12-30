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
    @Published var nowMonth: Int = 12
    @Published var dayOffset: Int = 0
    @Published var startOfMonth: Date = Date()

    static let shared = CalendarViewModel()
    
    init() {
        update()
    }
    
    func nextYear() {
        nowMonth += 1
        if nowMonth > 12 {
            nowYear += 1
            nowMonth = 1
        }
        update()
    }
    
    func lastYear() {
        nowMonth -= 1
        if nowMonth < 1 {
            nowYear -= 1
            nowMonth = 12
        }
        update()
    }
    
    func update() {
        startOfMonth = getStartOfMonth(year: nowYear, month: nowMonth)
        dayOffset = getDayOffset(date: Calendar(identifier: .gregorian).startOfDay(for: startOfMonth))
        ViewSwitcher.shared.setNavigationTitle(title: String(nowYear) + "/" + String(nowMonth))
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
        guard let date = Calendar(identifier: .gregorian).date(byAdding: .day, value: index - dayOffset, to: startOfMonth) else {
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
    func getStartOfMonth(year: Int, month: Int) -> Date {
        let comp = DateComponents(calendar: Calendar(identifier: .gregorian), year: year, month: month, day: 1)
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

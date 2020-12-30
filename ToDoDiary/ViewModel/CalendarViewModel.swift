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
    
    @Published var nowYear: Int = 2020
    @Published var nowMonth: Int = 12
    @Published var dayOffset: Int = 0
    @Published var lastDayOfMonth: Int = 30
    @Published var startOfMonth: Date = Date()
    
    var rowCount: Int {
        let total = dayOffset + lastDayOfMonth
        if total % 7 == 0 {
            return (dayOffset + lastDayOfMonth) / 7
        } else {
            return (dayOffset + lastDayOfMonth) / 7 + 1
        }
    }

    static let shared = CalendarViewModel()
    
    init() {
        let comp = Calendar(identifier: .gregorian).dateComponents([.year, .month], from: Date())
        
        guard let year = comp.year, let month = comp.month else {
            print("[error] failed to earn year and month")
            return
        }
        
        nowYear = year
        nowMonth = month
    }
    
    func nextMonth() {
        nowMonth += 1
        if nowMonth > 12 {
            nowYear += 1
            nowMonth = 1
        }
        update()
    }
    
    func lastMonth() {
        nowMonth -= 1
        if nowMonth < 1 {
            nowYear -= 1
            nowMonth = 12
        }
        update()
    }
    
    func update() {
        startOfMonth = CalendarManager.shared.getStartOfMonth(year: nowYear, month: nowMonth)
        dayOffset = CalendarManager.shared.getDayOffset(date: Calendar(identifier: .gregorian).startOfDay(for: startOfMonth))
        ViewSwitcher.shared.setNavigationTitle(title: String(nowYear) + "/" + String(nowMonth))
        lastDayOfMonth = CalendarManager.shared.getLastDayOfMonth(year: nowYear, month: nowMonth)
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

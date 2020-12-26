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
    
    // カレンダーの日付選択時に呼ばれる
    func selectIndex(index: Int) {
        let selectedDate: Date = CalendarManager.shared.getDateFromIndex(index: index)
        
        let formatDate: String = CalendarManager.shared.formatFullDate(date: selectedDate)
        
        if let _selectedEventArray = EventManager.shared.getEventArrayFromDate(date: formatDate) {
            selectedEventArray = _selectedEventArray
        } else {
            selectedEventArray = []
        }
        
        isShowingDetail = true
        selectedIndex = index
    }
}

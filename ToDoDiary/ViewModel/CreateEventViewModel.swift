//
//  CreateEventViewModel.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

class CreateEventViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var place: String = ""
    @Published var color: EventColor = .none
    @Published var notification: NotificationType = .none
    @Published var detail: String = ""
    @Published var rawStartTime: Date = Date() {
        didSet {
            didSetStart = true
        }
    }
    @Published var rawEndTime: Date = Date() {
        didSet {
            didSetEnd = true
        }
    }
    
    var event: Event?
    
    // TODO: 改善する
    var didSetStart: Bool = false
    var didSetEnd: Bool = false
    
    var startTime: Date? {
        get {
            if didSetStart { return rawStartTime }
            else { return nil }
        }
        set {
            if let value = newValue {
                rawStartTime = value
            }
        }
    }
    
    var endTime: Date? {
        get {
            if didSetEnd { return rawEndTime }
            else { return nil }
        }
        set {
            if let value = newValue {
                rawEndTime = value
            }
        }
    }
    
    // イベントの作成
    func createEvent() {
        guard title != "" else { return }

        // 前後の改行をなくす
        let _detail = detail.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 編集中である場合、重複させないためにそれを削除する
        // TODO: buggy
        if let _event = self.event {
            EventManager.shared.deleteEvent(event: _event)
        }
        
        for date in selectedDates {
            let year = Calendar.current.component(.year, from: date)
            let month = Calendar.current.component(.month, from: date)
            let day = Calendar.current.component(.day, from: date)
            
            var start: Date? = startTime
            var end: Date? = endTime
            
            if startTime != nil {
                var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: startTime!)
                components.year = year
                components.month = month
                components.day = day
                
                start = Calendar.current.date(from: components)
            }
            if endTime != nil {
                var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: endTime!)
                components.year = year
                components.month = month
                components.day = day
                
                end = Calendar.current.date(from: components)
            }
            
            let event = Event(title: title, color: color.rawValue, place: place != "" ? place : nil, startTime: start, endTime: end, notification: notification.rawValue, detail: _detail != "" ? _detail : nil)
            
            EventManager.shared.addEventToDictionary(event: event)
                
            // TODO: 複数イベント作成時に対応
            self.event = event
        }
    }
    
    // 入力欄の初期化
    func setUpEvent(event _event: Event?) {
        // イベントが設定されていなければreturn
        guard let event = _event else { return }
        
        title = event.title
        place = event.place ?? ""
        color = event.color
        startTime = event.startTime
        endTime = event.endTime
        notification = event.notification
        detail = event.detail ?? ""
        
        selectedDates = event.startTime != nil ? [event.startTime!] : []
        
        self.event = event
    }
    
    //
    // MARK: DateSelecter
    //
    
    // TODO: 初期値の設定
    @Published var year: Int = 2020
    @Published var month: Int = 12
    @Published var offset: Int = 0
    @Published var selectedIndexes: [Bool] = [Bool](repeating: false, count: 50)
    @Published var selectedDates: [Date] = []
    
    // 日にち選択用に月の最初の曜日を取得する
    func getOffsetForDateSelecter() -> Int {
        let components = DateComponents(calendar: Calendar.current, year: year, month: month, day: 0)
        guard let date = components.date else {
            print("[Error] GetDayOffset Failed")
            return 0
        }
        
        let comp = Calendar.current.dateComponents([.weekday], from: date)
        
        guard let offset: Int = comp.weekday else {
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
    
    func formatMonthAndDay(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "M/d"
        
        return formatter.string(from: date)
    }
    
    // year and date
    func calendarTitle() -> String {
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
    
    // 日付からindexを取得する
    func getIndexForDateSelecter(date: Date) -> Int {
        let comp = Calendar.current.dateComponents([.day], from: date)
        
        guard let day = comp.day else {
            print("[error] component earn failed")
            return 0
        }
        
        return day + offset
    }
    
    // 日付を選択した時に呼ばれる
    // selectedDatesに日付を追加する
    // すでに含まれていたら削除する
    func selectDate(index: Int) {
        let selectedDate: Date = getDateForDateSelecter(index: index)
        if selectedDates.contains(selectedDate) {
            selectedDates.remove(value: selectedDate)
        } else {
            selectedDates.append(getDateForDateSelecter(index: index))
        }
        
        // ISSUE: selectedDatesが増えてくると重いかも
        selectedDates = selectedDates.sorted(by: <)
    }
    
    // 前の月
    func prevMonth() {
        month -= 1
    
        if month == 0 {
            // 去年へ
            year -= 1
            month = 12
        }
        update()
    }
    
    // 次の月
    func nextMonth() {
        month += 1
        if month == 13 {
            // 来年へ
            year += 1
            month = 1
        }
        
        update()
    }
    
    // 選択している年、月が変わった時に呼ばれる
    func update() {
        offset = getOffsetForDateSelecter()
        selectedIndexes = [Bool](repeating: false, count: 50)
        
        // 選択されている日は選択済みにする
        // ISSUE: selectedDatesが増えてくると重いかも
        for date in selectedDates {
            let comp = Calendar.current.dateComponents([.year, .month], from: date)
            
            guard let _year = comp.year, let _month = comp.month else {
                print("[error] earn components failed")
                continue
            }
            
            if year == _year && month == _month {
                selectedIndexes[getIndexForDateSelecter(date: date)] = true
            }
        }
    }
    
    // 選択された日付のフォーマット
    // FIXME: 何かを変更すると常に呼ばれる
    func formatSelectedDates() -> String {
        var result: String = ""
        
        for date in selectedDates {
            // TODO: 昇順or降順で表示する
            result += formatMonthAndDay(date: date)
            result += ", "
        }
        
        // 最後のカンマと空白を削除する
        if selectedDates.count > 0 { result = String(result.dropLast(2)) }
        
        return result
    }
}

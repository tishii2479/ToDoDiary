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
    @Published var selectedDates: [Date] = []
    @Published var notification: NotificationType = .none {
        didSet {
            print(notification)
        }
    }
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
    var didSetDate: Bool = false
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
    
    var dateText: String {
        return ""
    }
    
    var notificationText: String {
        return notification.text
    }
    
    // イベントの作成
    func createEvent() {
        guard title != "" else { return }

        // 前後の改行をなくす
        let _detail = detail.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 編集中である場合、重複させないためにそれを削除する
        if let _event = self.event {
            EventManager.shared.deleteEvent(event: _event)
        }
        
        // 日時が選択されていない場合、ToDoとしてのみ追加する
        if selectedDates.count == 0 {
            let event = Event(title: title, color: color.rawValue, place: place != "" ? place : nil, date: nil, startTime: startTime, endTime: endTime, notification: notification.rawValue, detail: _detail != "" ? _detail : nil)
            
            EventManager.shared.addEventToDictionary(event: event)
            
            // 作成後に編集する場合のために設定
            self.event = event
            
            print("[debug] create event")
            print(event)
            return
        }
        
        for date in selectedDates {
            let year = Calendar(identifier: .gregorian).component(.year, from: date)
            let month = Calendar(identifier: .gregorian).component(.month, from: date)
            let day = Calendar(identifier: .gregorian).component(.day, from: date)
            
            var start: Date? = startTime
            var end: Date? = endTime
            
            if startTime != nil {
                var components = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: startTime!)
                components.year = year
                components.month = month
                components.day = day
                
                start = Calendar(identifier: .gregorian).date(from: components)
            }
            
            if endTime != nil {
                var components = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: endTime!)
                components.year = year
                components.month = month
                components.day = day
                
                end = Calendar(identifier: .gregorian).date(from: components)
            }
            
            let event = Event(title: title, color: color.rawValue, place: place != "" ? place : nil, date: date, startTime: start, endTime: end, notification: notification.rawValue, detail: _detail != "" ? _detail : nil)
            
            EventManager.shared.addEventToDictionary(event: event)
                
            // 作成後に編集する場合のために設定
            // TODO: 複数イベント作成時に対応
            self.event = event
            
            print("[debug] create event")
            print(event)
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
        
        selectedDates = event.date != nil ? [event.date!] : []
        
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
    
    // 日にち選択用に月の最初の曜日を取得する
    func getOffsetForDateSelecter() -> Int {
        let components = DateComponents(calendar: Calendar(identifier: .gregorian), year: year, month: month, day: 0)
        guard let date = components.date else {
            print("[Error] GetDayOffset Failed")
            return 0
        }
        
        let comp = Calendar(identifier: .gregorian).dateComponents([.weekday], from: date)
        
        guard let offset: Int = comp.weekday else {
            print("[Error] GetDayOffset Failed")
            return 0
        }
        
        return (offset % 7) - 1
    }
    
    // 日にち選択用の日付取得
    func getDateForDateSelecter(index: Int) -> Date {
        let components = DateComponents(calendar: Calendar(identifier: .gregorian), year: year, month: month, day: index - offset)
        guard let date = components.date else {
            print("[Error] GetDateFromIndex Failed")
            return Date()
        }
        
        return date
    }
    
    // 日付からindexを取得する
    func getIndexForDateSelecter(date: Date) -> Int {
        let comp = Calendar(identifier: .gregorian).dateComponents([.day], from: date)
        
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
            selectedDates.append(selectedDate)
        }
        
        // 選択された日付を昇順にソート
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
            let comp = Calendar(identifier: .gregorian).dateComponents([.year, .month], from: date)
            
            guard let _year = comp.year, let _month = comp.month else {
                print("[error] earn components failed")
                continue
            }
            
            if year == _year && month == _month {
                selectedIndexes[getIndexForDateSelecter(date: date)] = true
            }
        }
    }

    // ISSUE: 重いかも
    // 対象の日付が表示すべきかを返す
    func isTargetDate(date: Date) -> Bool {
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
    
    //
    // MARK: Formatter
    //
    
    // year and date
    func calendarTitle() -> String {
        let components = DateComponents(calendar: Calendar(identifier: .gregorian), year: year, month: month)
        guard let date = components.date else {
            print("[Error] GetDateFromIndex Failed")
            return ""
        }
        
        return DateFormatter.format(date: date, format: "y/M")
    }
    
    // 選択された日付のフォーマット
    // FIXME: 何かを変更すると常に呼ばれる
    func formatSelectedDates() -> String {
        var result: String = ""
        
        for date in selectedDates {
            // TODO: 昇順or降順で表示する
            result += DateFormatter.format(date: date, format: "M/d")
            result += ", "
        }
        
        // 最後のカンマと空白を削除する
        if selectedDates.count > 0 { result = String(result.dropLast(2)) }
        
        return result
    }

}

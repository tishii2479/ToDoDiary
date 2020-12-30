//
//  EventViewModel.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

enum EventMode: String {
    case new = "作成"
    case edit = "編集"
    
    var action: String {
        switch self {
        case .new:
            return "作成"
        case .edit:
            return "完了"
        }
    }
}

enum EventType: String {
    case event = "予定"
    case todo = "ToDo"
}

class EventViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var place: String = ""
    @Published var color: EventColor = .none
    @Published var selectedDates: [Date] = []
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
    
    var mode: EventMode = .new
    var content: EventType = .event
    var pageTitle: String {
        return content.rawValue + "の" + mode.rawValue
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
    
    // 初期化
    init(content: EventType = .event) {
        self.content = content
    }
    
    // イベントの作成
    func createEvent() {
        if let events = createEventData() {
            EventManager.shared.addEventToDictionary(events: events)
            
            // 作成ページを閉じる
            ViewSwitcher.shared.isShowingModal = false
            
            // ToDoListの更新
            ToDoListViewModel.shared.setUpEvents()
            
            // 詳細表示を閉じる
            // 編集した場合、消去したイベントが表示されるのを防ぐため
            CalendarViewModel.shared.isShowingDetail = false
        } else {
            // 作成時エラー
            
        }
    }

    // 入力欄の初期化
    func setUpEvent(date _date: Date?, event _event: Event?) {
        // 日付が設定されていればそれを設定する
        if let date = _date {
            mode = .new
            selectedDates = [date]
            return
        }
    
        // イベントが設定されていなければreturn
        guard let event = _event else {
            mode = .new
            return
        }
        
        // 編集モード
        mode = .edit
        
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
    
    func deleteEvent() {
        guard let _event = event else {
            print("[error] failed to delete event")
            return
        }

        ViewSwitcher.shared.isShowingModal = false
        EventManager.shared.deleteEvent(event: _event)
    }
    
    // イベントデータの作成
    func createEventData() -> [Event]? {
        guard title != "" else { return nil }

        // 前後の改行をなくす
        let _detail = detail.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 編集中である場合、重複させないためにそれを削除する
        if let _event = self.event {
            EventManager.shared.deleteEvent(event: _event)
        }
        
        var result: [Event] = []
        
        // 日時が選択されていない場合、ToDoとしてのみ追加する
        if selectedDates.count == 0 {
            let event = Event(title: title, color: color.rawValue, place: place != "" ? place : nil, date: nil, startTime: startTime, endTime: endTime, notification: notification.rawValue, detail: _detail != "" ? _detail : nil)
            
            // 作成後に編集する場合のために設定
//            self.event = event
            
            print("[debug] create event")
            print(event)
            
            result = [event]
            return result
        }
        
        // 色の設定
        // 色が設定されていなかった場合、ランダムに色を割り当てる
        // 複数ある場合には、それを全て同じ色にする
        var rawColor: Int = -1
        if color == .none {
            rawColor = EventColor.random()
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
            
            let event = Event(title: title, color: color != .none ? color.rawValue : rawColor, place: place != "" ? place : nil, date: date, startTime: start, endTime: end, notification: notification.rawValue, detail: _detail != "" ? _detail : nil)
                
            // 作成後に編集する場合のために設定
            // TODO: 複数イベント作成時に対応
//            self.event = event
            
            print("[debug] create event")
            print(event)
            
            result.append(event)
        }
            
        return result
    }
   
    //
    // MARK: Formatter
    //
    
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

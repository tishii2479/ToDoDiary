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
    @Published var startTime: Date?
    @Published var endTime: Date?
    @Published var notification: NotificationType = .none
    @Published var detail: String = ""
    
    private var event: Event?
    
    // イベントの作成
    func createEvent() {
        guard title != "" else { return }
        
        // 前後の改行をなくす
        let _detail = detail.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 編集中である場合、重複させないためにそれを削除する
        if let _event = self.event {
            EventManager.shared.deleteEvent(event: _event)
        }
        
        let event = Event(title: title, color: color.rawValue, place: place != "" ? place : nil, startTime: startTime, endTime: endTime, notification: notification.rawValue, detail: _detail != "" ? _detail : nil)
        
        EventManager.shared.addEventToDictionary(event: event)
        
        self.event = event
        
        print("add event \(event)")
    }
    
    // 入力欄の初期化
    func setUpEvents(event _event: Event?) {
        // イベントが設定されていなければreturn
        guard let event = _event else { return }
        
        title = event.title
        place = event.place ?? ""
        color = event.color
        startTime = event.startTime
        endTime = event.endTime
        notification = event.notification
        detail = event.detail ?? ""
        
        self.event = event
    }
}

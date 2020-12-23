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
    
    func createEvent() {
        guard title != "" else { return }
        
        // 前後の改行をなくす
        let _detail = detail.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let event = Event(title: title, color: color.rawValue, place: place != "" ? place : nil, startTime: startTime, endTime: endTime, notification: notification.rawValue, detail: _detail != "" ? _detail : nil)
        
        EventManager.shared.addEventToDictionary(event: event)
        
        print("add event \(event)")
    }
}

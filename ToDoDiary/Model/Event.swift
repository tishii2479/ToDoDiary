//
//  Event.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import Foundation
import SwiftUI
import RealmSwift

class Event {
    var title: String
    var color: EventColor
    var place: String?
    var startTime: Date?
    var endTime: Date?
    var notification: Int
    var detail: String?
    
    // テスト用
    static let test = Event(title: "アルバイトをする", startTime: Date())
    
    var eventColor: Color {
        return Color.red
    }
    
    init (title: String, color: EventColor = .none, place: String? = nil, startTime: Date? = nil, endTime: Date? = nil, notification: Int = 0, detail: String? = nil) {
        self.title = title
        self.place = place
        self.startTime = startTime
        self.endTime = endTime
        self.notification = notification
        self.detail = detail
        
        if color == .none {
            self.color = EventColor.random()
        } else {
            self.color = color
        }
    }
    
    func formatTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        
        var result = ""
        
        if startTime == nil && endTime == nil { return "" }
        
        if let start = startTime {
            result += formatter.string(from: start)
        } else {
            result += "未定"
        }
        
        result += " - "
        
        if let end = endTime {
            result += formatter.string(from: end)
        } else {
            result += "未定"
        }
        
        return result
    }
    
}

//
//  Event.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import Foundation

class Event {
    var title: String
    var startTime: Date
    var endTime: Date
    
    static let test = Event(title: "アルバイト", startTime: Date(), endTime: Date())
    
    init (title: String, startTime: Date, endTime: Date) {
        self.title = title
        self.startTime = startTime
        self.endTime = endTime
    }
    
    func formatTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        
        return formatter.string(from: startTime) + " - " + formatter.string(from: endTime)
    }
    
}

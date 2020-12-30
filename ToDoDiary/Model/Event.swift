//
//  Event.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI
import RealmSwift

class Event: Object {
    @objc dynamic var title: String
    @objc dynamic var rawColor: Int
    @objc dynamic var place: String?
    @objc dynamic var date: Date?
    @objc dynamic var startTime: Date?
    @objc dynamic var endTime: Date?
    @objc dynamic var rawNotification: Int
    @objc dynamic var detail: String?
    @objc dynamic var rawEventType: Int
    @objc dynamic var isDone: Bool
    
    var notification: NotificationType {
        get {
            guard let type = NotificationType(rawValue: rawNotification) else {
                print("[error] type not found")
                return .none
            }
            return type
        }
    }
    var color: EventColor {
        get {
            guard let color = EventColor(rawValue: rawColor) else {
                print("[error] color not found")
                return .none
            }
            return color
        }
    }
    var type: EventType {
        get {
            guard let type = EventType(rawValue: rawEventType) else {
                print("[error] type not found")
                return .event
            }
            return type
        }
    }
    
    // テスト用
    static let test = Event(title: "アルバイトをする", startTime: Date(), eventType: .event)
    
    var eventColor: Color {
        return color.color
    }
    
    required init() {
        title = ""
        rawNotification = 0
        rawColor = 0
        rawEventType = 0
        isDone = false
    }
    
    init (title: String, color: Int = -1, place: String? = nil, date: Date? = nil, startTime: Date? = nil, endTime: Date? = nil, notification: Int = 0, detail: String? = nil, eventType: EventType, isDone: Bool = false) {
        self.title = title
        self.place = place
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.detail = detail
        self.rawNotification = notification
        self.rawEventType = eventType.rawValue
        self.isDone = isDone
        
        // colorが設定されていなかったらランダムで割り付ける
        if color == -1 {
            self.rawColor = EventColor.random()
        } else {
            self.rawColor = color
        }
    }
    
    // 時間のフォーマット
    func formatTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        
        var result = ""
        
        if startTime == nil && endTime == nil { return "終日" }
        
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
    
    // イベントを完了する
    func setDone(isDone _isDone: Bool) {
        do {
            let realm = try Realm()
            try realm.write {
                isDone = _isDone
            }
        } catch {
            print("[error] realm failed")
        }
    }
}

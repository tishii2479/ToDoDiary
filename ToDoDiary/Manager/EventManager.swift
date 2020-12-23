//
//  EventManager.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import Foundation

class EventManager {
    static let shared = EventManager()
    
    private var eventDictionary: Dictionary<String, [Event]> = [:]
    
    init () {
        print("[debug] EventManager init")
        
        eventDictionary = setUpEventDictionary()
    }
    
    // イベント辞書構築
    // startTimeがnilの場合は、dic[""]にイベントをまとめている
    // TODO: データベースからイベント検索
    func setUpEventDictionary() -> Dictionary<String, [Event]> {
        var dic: Dictionary<String, [Event]> = [:]
        
        for _ in 0 ... 2 {
            let event: Event = Event.test
            let date: String = CalendarManager.shared.formatFullDate(date: event.startTime)

            if dic[date] == nil {
                dic[date] = []
            }

            dic[date]?.append(Event.test)
        }
        
        return dic
    }
    
    // 日時の文字列からイベントの配列を返す
    func getEventArrayFromDate(date: String) -> [Event]? {
        return eventDictionary[date]
    }
    
    // イベントを辞書に追加する
    func addEventToDictionary(event: Event) {}
}

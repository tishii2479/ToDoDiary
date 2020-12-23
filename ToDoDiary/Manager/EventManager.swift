//
//  EventManager.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import Foundation
import RealmSwift

class EventManager {
    static let shared = EventManager()
    
    // イベントの辞書
    // eventDictionary[""]は日時登録されていないもの
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
    // なければnilを返す
    func getEventArrayFromDate(date: String) -> [Event]? {
        return eventDictionary[date]
    }
    
    // イベントを辞書に追加する
    func addEventToDictionary(event: Event) {}
    
    // TODOのイベントを返す
    func getToDoArray() -> [Event] {
        return eventDictionary[CalendarManager.shared.formatFullDate(date: Date())]!
    }
}

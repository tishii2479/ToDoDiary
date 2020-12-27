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
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // realmのマイグレーション
        migrate()
        
        eventDictionary = setUpEventDictionary()
    }
    
    // イベント辞書構築
    // dateがnilの場合は、dic[""]にイベントをまとめている
    // TODO: データベースからイベント検索
    func setUpEventDictionary() -> Dictionary<String, [Event]> {
        var dic: Dictionary<String, [Event]> = [:]
        
        do {
            let realm = try Realm()
            let events = realm.objects(Event.self)
            
            for event in events {
                let date: String = CalendarManager.shared.formatFullDate(date: event.date)
                if dic[date] == nil {
                    dic[date] = []
                }

                dic[date]?.append(event)
            }
        } catch {
            print("[error] realm fail")
        }
        
        return dic
    }
    
    // 日時の文字列からイベントの配列を返す
    // なければnilを返す
    func getEventArrayFromDate(date: String) -> [Event]? {
        return eventDictionary[date]
    }
    
    // イベントを辞書に追加する
    func addEventToDictionary(events: [Event]) {
        do {
            let realm = try Realm()
            
            try realm.write {
                for event in events {
                    realm.add(event)
                }
            }
        } catch {
            print("[error] realm fail")
        }
        
        // TODO: 軽量化
        eventDictionary = setUpEventDictionary()
    }
    
    // ToDoのイベントを返す
    func getToDoArray(searchText: String) -> [Event] {
//        TODO: ソート基準を変える
//        let sortProperties = [
//            SortDescriptor(keyPath: "date", ascending: false)
//        ]
        
        do {
            let realm = try Realm()
            let search: String = "*" + searchText + "*"
            
            let events = realm.objects(Event.self).filter("title LIKE '\(search)'").filter("date == nil")//.sorted(by: sortProperties)
            
            return Array(events)
        } catch {
            print("[error] realm fail")
            return []
        }
    }
    
    // イベントの削除
    func deleteEvent(event: Event) {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.delete(event)
            }
        } catch {
            print("[error] realm fail")
        }
        
        // TODO: 軽量化
        eventDictionary = setUpEventDictionary()
    }
    
    private func migrate() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let _ = try! Realm(configuration: config)
    }
}

//
//  ToDoListViewModel.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

class ToDoListViewModel: ObservableObject {
    @Published var searchText: String = "" {
        didSet {
            // 検索ワードが更新されたら、配列をアップデートする
            updateEvents()
        }
    }
    @Published var createText: String = ""
    @Published var selectedColor: EventColor = .none
    @Published var events: [Event] = []
    
    init() {
        setUpEvents()
    }
    
    // イベント作成ボタンが押されたとき
    func createEvent() {
        // 件名が入力されていない場合はreturn
        guard createText != "" else { return }
        
        let event = Event(title: createText, color: selectedColor.rawValue)
        events.append(event)
        
        EventManager.shared.addEventToDictionary(event: event)
        
        resetCreateInput()
    }
    
    // イベント配列のセットアップ
    func setUpEvents() {
        events = EventManager.shared.getToDoArray(searchText: "")
    }
    
    func updateEvents() {
        events = EventManager.shared.getToDoArray(searchText: searchText)
        print(events)
    }
    
    // 作成欄のリセット
    func resetCreateInput() {
        selectedColor = .none
        createText = ""
    }
    
    // 検索欄のリセット
    func resetSearchInput() {
        searchText = ""
    }
}

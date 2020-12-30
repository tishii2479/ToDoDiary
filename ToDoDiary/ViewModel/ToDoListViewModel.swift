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
    @Published var selectedIndexes = Set<Int>()
    
    static let shared = ToDoListViewModel()
    
    init() {
        setUpEvents()
    }
    
    // イベント作成ボタンが押されたとき
    func createEvent() {
        // 件名が入力されていない場合はreturn
        guard createText != "" else { return }
        
        let event = Event(title: createText, color: selectedColor.rawValue)
        events.append(event)
        
        EventManager.shared.addEventToDictionary(events: [event])
        
        resetCreateInput()
    }
    
    // イベント配列のセットアップ
    func setUpEvents() {
        events = EventManager.shared.getToDoArray(searchText: "")
    }
    
    func updateEvents() {
        events = EventManager.shared.getToDoArray(searchText: searchText)
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
    
    // 行入れ替え処理
    func rowReplace(_ from: IndexSet, _ to: Int) {
        events.move(fromOffsets: from, toOffset: to)
        print(selectedIndexes)
    }
    
    // 行削除処理
    func rowDelete(at offsets: IndexSet) {
        guard let index = offsets.first else {
            print("[error] failed to delete row")
            return
        }
        
        EventManager.shared.deleteEvent(event: events[index])
        
        events.remove(atOffsets: offsets)
    }
    
    // 選択されたイベントの削除
    func completeSelectedEvents() {
        print(selectedIndexes)
    }
}

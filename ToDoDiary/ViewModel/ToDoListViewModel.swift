//
//  ToDoListViewModel.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

class ToDoListViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var createText: String = ""
    @Published var selectedColor: EventColor = .none
    @Published var events: [Event] = []
    
    init() {
        setUpEvents()
    }
    
    func createEvent() {
        // 件名が入力されていない場合はreturn
        guard createText != "" else { return }
        
        let event = Event(title: createText, color: selectedColor.rawValue)
        events.append(event)
        
        EventManager.shared.addEventToDictionary(event: event)
        
        resetCreateInput()
    }
    
    func setUpEvents() {
        events = EventManager.shared.getToDoArray(searchText: "")
    }
    
    func resetCreateInput() {
        selectedColor = .none
        createText = ""
    }
}

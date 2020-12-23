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
        
        events.append(Event(title: createText, color: selectedColor.rawValue))
        
        resetCreateInput()
    }
    
    func setUpEvents() {
        events = EventManager.shared.getToDoArray()
    }
    
    func resetCreateInput() {
        selectedColor = .none
        createText = ""
    }
}

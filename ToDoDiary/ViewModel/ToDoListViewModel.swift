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
    
    func createEvent(title: String, selectedColor color: EventColor) {
        // 件名が入力されていない場合はreturn
        guard title != "" else { return }
        
        events.append(Event(title: title, color: color))
        
        resetCreateInput()
    }
    
    func setUpEvents() {
        events = [Event.test, Event.test]
    }
    
    func resetCreateInput() {
        selectedColor = .none
        createText = ""
    }
}

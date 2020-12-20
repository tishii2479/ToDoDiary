//
//  CurrentView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct CurrentView: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    var body: some View {
        ZStack {
            switch viewSwitcher.currentView {
            case .calendar:
                CalendarView()
            case .toDoList:
                ToDoListView()
            }
        }
    }
}

struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentView()
    }
}

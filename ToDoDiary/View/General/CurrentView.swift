//
//  CurrentView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct CurrentView: View {
    var body: some View {
        ZStack {
            CalendarView()
            ToDoListView()
        }
    }
}

struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentView()
    }
}

//
//  ToDoListView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI

// TODOのセル
fileprivate struct ToDoListCell: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    var event: Event
    
    var body: some View {
        Group {
            // 削除されていないかチェック
            if event.isInvalidated {
                EmptyView()
            }
            else {
                Button(action: {
                    // Set target event to selected event
                    viewSwitcher.targetEvent = event
                    viewSwitcher.isShowingModal = true
                }) {
                    HStack {
                        event.eventColor.frame(width: 2)
                            .padding(.horizontal, 15)
                        
                        Text(event.title)
                            .font(Font.custom(FontManager.japanese, size: 14))
                            .foregroundColor(ColorManager.character)
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                    .background(ColorManager.back)
                }
            }
        }
    }
}

struct ToDoListView: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    @ObservedObject var toDoList: ToDoListViewModel = ToDoListViewModel()
    
    var body: some View {
        ZStack {
            ColorManager.back
            
            VStack(spacing: 0) {
                ListSearchField(toDoList: toDoList)
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(0 ..< toDoList.events.count, id: \.self) { index in
                            ToDoListCell(event: toDoList.events[index])
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            
            VStack {
                Spacer()
                ColorPalette(selectedColor: $toDoList.selectedColor)
                ToDoTextField(toDoList: toDoList)
            }
            .sheet(isPresented: $viewSwitcher.isShowingModal) {
                EventView()
                    .environmentObject(EventViewModel(content: .todo))
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}

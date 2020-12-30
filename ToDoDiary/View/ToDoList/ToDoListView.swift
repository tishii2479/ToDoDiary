//
//  ToDoListView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI

// TODOのセル
fileprivate struct ToDoListCell: View {
    @Environment(\.editMode) var editMode
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
                    viewSwitcher.showModal(targetEvent: event)
                }) {
                    HStack {
                        event.eventColor.frame(width: 2)
                            .padding(.trailing, 10)
                        
                        Text(event.title)
                            .font(Font.custom(FontManager.japanese, size: 14))
                            .foregroundColor(ColorManager.character)
                        Spacer()
                        
                        // 複数選択モードでないとき
                        if editMode?.wrappedValue != .active {
                            Text(event.formatTime())
                                .font(Font.custom(FontManager.japanese, size: 14))
                                .foregroundColor(ColorManager.character)
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width, minHeight: 40, maxHeight: 40)
            }
        }
        .listRowBackground(ColorManager.back)
    }
}

struct ToDoListView: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    @ObservedObject var toDoList: ToDoListViewModel = ToDoListViewModel()
    
    var body: some View {
        ZStack {
            ColorManager.back
            
            VStack(spacing: 0) {
                ListSearchField(toDoList: toDoList)
                
                List(selection: $toDoList.selectedIndexes) {
                    ForEach(toDoList.events, id: \.self) { event in
                        ToDoListCell(event: event)
                    }
                    .onDelete(perform: toDoList.rowDelete)
                    .onMove(perform: toDoList.rowReplace)
                }
                .padding(.horizontal, 10)
                .frame(minWidth: 0, maxWidth: .infinity)
                .animation(.default)
            }
            
            VStack {
                Spacer()
                ColorPalette(selectedColor: $toDoList.selectedColor)
                ToDoTextField(toDoList: toDoList)
            }
            .sheet(isPresented: $viewSwitcher.isShowingModal) {
                EventView()
                    .environmentObject(EventViewModel(content: .todo))
                    .colorScheme(viewSwitcher.colorTheme) // FIXME: これだけカラーが反映されない
            }
        }
        .onAppear {
            viewSwitcher.setNavigationTitle(title: "ToDo")
            
            // リストの色の設定
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().backgroundColor = UIColor(ColorManager.back)
//            UITableViewCell.appearance().tintColor = UIColor(ColorManager.redCharacter)
        }
        .onDisappear {
            // 編集状態をやめる
            editMode?.wrappedValue = .inactive
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView().environmentObject(ViewSwitcher())
    }
}

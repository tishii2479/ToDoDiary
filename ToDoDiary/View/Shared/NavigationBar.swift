//
//  NavigationBar.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct NavigationBar: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    @Environment(\.editMode) var editMode
    
    var body: some View {
        ZStack {
            // 背景色
            ColorManager.main
                .edgesIgnoringSafeArea(.top)
        
            // タイトル
            HStack {
                Text(viewSwitcher.navigationTitle ?? "")
                    .font(Font.custom(FontManager.number, size: 24))
                    .bold()
                    .foregroundColor(ColorManager.character)
                Spacer()
                
                trailingItems(viewType: viewSwitcher.currentView)
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 60)
        .shadow(color: ColorManager.shadow, radius: 5, x: 0, y: 5)
        .zIndex(1)
    }
    
    func trailingItems(viewType: ViewType) -> some View {
        return Group {
            switch viewType {
            case .calendar:
                HStack {
                    Button(action: {
                        // 先月へ
                        CalendarViewModel.shared.lastMonth()
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(ColorManager.image)
                    }
                    .padding(.trailing, 20)
                    
                    Button(action: {
                        // 来月へ
                        CalendarViewModel.shared.nextMonth()
                    }) {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(ColorManager.image)
                    }
                }
            case .toDoList:
                HStack {
                    Button(action: {
                        // 編集モードの切り替え
                        self.editMode?.wrappedValue.toggle()
                    }) {
                        if self.editMode?.wrappedValue == .active {
                            Image(systemName: "multiply")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(ColorManager.image)
                        } else {
                            Image(systemName: "arrow.up.arrow.down")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(ColorManager.image)
                        }
                    }
                    
                    // 編集モードの時
                    if self.editMode?.wrappedValue == .active {
                        Button(action: {
                            ToDoListViewModel.shared.completeSelectedEvents()
                        }) {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(ColorManager.image)
                        }
                    }
                }
            default:
                EmptyView()
            }
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}

//
//  ToDoListView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI

// 検索バー
fileprivate struct SimpleSearchField: View {
    @ObservedObject var toDoListViewModel: ToDoListViewModel
    
    var body: some View {
        ZStack {
            // 丸みのついた枠線
            RoundedRectangle(cornerRadius: 20)
                .stroke(ColorManager.denseBorder, lineWidth: 1)
            
            TextField("aa", text: $toDoListViewModel.searchText)
                .font(Font.custom(FontManager.japanese, size: 14))
                .padding(.horizontal, 20)
                .frame(height: 40)
            
            HStack {
                Spacer()
                
                Button(action: {
                    print("delete")
                }) {
                    Text("削除")
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(10)
        .frame(height: 60)
    }
}

// TODOのセル
fileprivate struct ToDoListCell: View {
    var event: Event
    
    var body: some View {
        HStack {
            event.color.color().frame(width: 2)
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

// 新規作成テキストフィールド
fileprivate struct ToDoTextfield: View {
    @ObservedObject var toDoListViewModel: ToDoListViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
            .fill(ColorManager.main)
            .frame(minWidth: 0, maxWidth: 400, minHeight: 50, maxHeight: 50)
            .shadow(color: ColorManager.shadow, radius: 5, x: 0, y: 5)
            
            HStack {
                TextField("新規...", text: $toDoListViewModel.createText)
                    .font(Font.custom(FontManager.japanese, size: 14))
                    .foregroundColor(ColorManager.character)
                
                Button(action: {
                    toDoListViewModel.createEvent(title:  toDoListViewModel.createText, selectedColor: toDoListViewModel.selectedColor)
                }) {
                    Text("追加")
                }
            }
            .padding(.horizontal, 25)
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 40)
    }
}

struct ToDoListView: View {
    @ObservedObject var toDoListViewModel = ToDoListViewModel()
    
    var body: some View {
        ZStack {
            ColorManager.back
            
            VStack(spacing: 0) {
                SimpleSearchField(toDoListViewModel: toDoListViewModel)
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(0 ..< toDoListViewModel.events.count, id: \.self) { index in
                            ToDoListCell(event: toDoListViewModel.events[index])
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            
            VStack {
                Spacer()
                ColorPalette(selectedColor: $toDoListViewModel.selectedColor)
                ToDoTextfield(toDoListViewModel: toDoListViewModel)
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}

//
//  ToDoTextField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

// 新規作成テキストフィールド
struct ToDoTextField: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    @ObservedObject var toDoList: ToDoListViewModel
    
    var body: some View {
        ZStack {
            // 背景
            RoundedRectangle(cornerRadius: 25)
                .fill(ColorManager.main)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                .shadow(color: ColorManager.shadow, radius: 5, x: 0, y: 5)
            
            TextField("新規...", text: $toDoList.createText, onCommit: toDoList.createEvent)
                .font(Font.custom(FontManager.japanese, size: 14))
                .foregroundColor(ColorManager.character)
                .frame(height: 50)
                .padding(.leading, 20)
            
            // ボタン類
            HStack {
                Spacer()
                Button(action: {
                    toDoList.createEvent()
                }) {
                    Text("追加")
                }
                
                // TODO: 位置検討
                Button(action: {
                    viewSwitcher.showModal()
                }) {
                    Text("詳細")
                }
            }
            .padding(.horizontal, 25)
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 40)
    }
}

struct ToDoTextfield_Previews: PreviewProvider {
    static var previews: some View {
        ToDoTextField(toDoList: ToDoListViewModel())
    }
}

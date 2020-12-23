//
//  ListSearchField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

// 検索バー
struct ListSearchField: View {
    @ObservedObject var toDoList: ToDoListViewModel
    
    var body: some View {
        ZStack {
            // 丸みのついた枠線
            RoundedRectangle(cornerRadius: 20)
                .stroke(ColorManager.denseBorder, lineWidth: 1)

            TextField("aa", text: $toDoList.searchText)
                .font(Font.custom(FontManager.japanese, size: 14))
                .padding(.horizontal, 20)
                .frame(height: 40)
            
            // 削除ボタン
            HStack {
                Spacer()
                
                Button(action: {
                    toDoList.resetSearchInput()
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

struct ListSearchField_Previews: PreviewProvider {
    static var previews: some View {
        ListSearchField(toDoList: ToDoListViewModel())
    }
}

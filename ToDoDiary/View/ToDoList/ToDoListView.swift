//
//  ToDoListView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI

// 検索バー
fileprivate struct SimpleSearchField: View {
    @Binding var value: String
    
    var body: some View {
        ZStack {
            // 丸みのついた枠線
            RoundedRectangle(cornerRadius: 20)
                .stroke(ColorManager.denseBorder, lineWidth: 1)
            
            TextField("aa", text: $value)
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
    var title: String
    
    var body: some View {
        HStack {
            Color.red.frame(width: 1)
                .padding(.horizontal, 15)
            
            Text(title)
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
    @Binding var value: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
            .fill(ColorManager.main)
            .frame(minWidth: 0, maxWidth: 400, minHeight: 50, maxHeight: 50)
            .shadow(color: ColorManager.shadow, radius: 5, x: 0, y: 5)
            
            HStack {
                TextField("新規...", text: $value)
                    .font(Font.custom(FontManager.japanese, size: 14))
                    .foregroundColor(ColorManager.character)
                
                Button(action: {
                    print("add")
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
    @State var searchText: String = ""
    @State var createText: String = ""
    
    var body: some View {
        ZStack {
            ColorManager.back
            
            VStack(spacing: 0) {
                SimpleSearchField(value: $searchText)
                
                ScrollView {
                    VStack(spacing: 0) {
                        ToDoListCell(title: "シフト提出")
                        ToDoListCell(title: "シフト提出")
                        ToDoListCell(title: "シフト提出")
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            
            VStack {
                Spacer()
                ToDoTextfield(value: $createText)
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}

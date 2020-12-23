//
//  CreateEventView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI

fileprivate struct SimpleDivider: View {
    var body: some View {
        Divider()
            .background(ColorManager.border)
    }
}

fileprivate struct SimpleTextField: View {
    @Binding var value: String
    var placeHolder: String
    
    var body: some View {
        TextField(placeHolder, text: $value)
            .foregroundColor(ColorManager.character)
            .font(Font.custom(FontManager.japanese, size: 14))
            .frame(height: 40)
            .padding(.horizontal, 10)
            .background(ColorManager.back)
    }
}

struct CreateEventView: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    @ObservedObject var createEvent: CreateEventViewModel = CreateEventViewModel()
    
    var body: some View {
        // TextEditorの背景色を透明に
        UITextView.appearance().backgroundColor = .clear
        
        return ZStack {
            ColorManager.main
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // ヘッダー
                ZStack {
                    Text("予定の作成")
                        .foregroundColor(ColorManager.character)
                        .font(Font.custom(FontManager.japanese, size: 14))
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            createEvent.createEvent()
                        }) {
                            Text("追加")
                                .foregroundColor(ColorManager.redCharacter)
                                .font(Font.custom(FontManager.japanese, size: 14))
                        }
                        .padding(.trailing, 15)
                    }
                }
                .background(ColorManager.main)
                .frame(height: 60)
                
                // 入力欄
                ScrollView {
                    VStack(spacing: 0) {    // ScrollViewのspacingを消す
                        Group {
                            SimpleDivider()
                            SimpleTextField(value: $createEvent.title, placeHolder: "件名")
                            SimpleDivider()
                            SimpleTextField(value: $createEvent.place, placeHolder: "場所")
                            SimpleDivider()
                        }
                        
                        Spacer().frame(height: 50)
                        
                        Group {
                            SimpleDivider()
                            SimpleTextField(value: $createEvent.title, placeHolder: "件名")
                            SimpleDivider()
                        }
                        
                        Spacer().frame(height: 50)
                        
                        Group {
                            SimpleDivider()
                            SimpleTextField(value: $createEvent.title, placeHolder: "件名")
                            SimpleDivider()
                        }
                        
                        Spacer().frame(height: 50)
                        
                        ZStack {
                            ColorManager.back
                            
                            VStack {
                                SimpleDivider()
                                TextEditor(text: $createEvent.detail)
                                    .padding(.horizontal, 10)
                                SimpleDivider()
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 160)
                    }
                }
            }
        }
        .colorScheme(.dark) // FIXME: これだけカラーが反映されない
    }
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
    }
}

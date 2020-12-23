//
//  CreateEventView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI

enum PulldownType {
    case date
    case notification
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
                    VStack(spacing: 0) {
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
                            SimplePulldownField(type: .date, title: "時刻", value: "未設定", event: $createEvent.event)
                            SimpleDivider()
                        }
                        
                        Spacer().frame(height: 50)
                        
                        Group {
                            SimpleDivider()
                            SimplePulldownField(type: .notification, title: "通知", value: "未設定", event: $createEvent.event)
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
        .onAppear {
            print("appear create event")
            createEvent.setUpEvents(event: viewSwitcher.targetEvent)
        }
    }
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
    }
}

//
//  EventView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    @EnvironmentObject var createEvent: EventViewModel
    
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
                            ListDivider()
                            ListTextField(value: $createEvent.title, placeHolder: "件名")
                            ListDivider()
                            ListTextField(value: $createEvent.place, placeHolder: "場所")
                            ListDivider()
                        }
                        
                        Spacer().frame(height: 20)
                        
                        ColorPalette(selectedColor: $createEvent.color)
                        
                        Spacer().frame(height: 20)
                        
                        Group {
                            ListDivider()
                            ListPulldownField(type: .date, title: "時刻", value: createEvent.dateText, isAlwaysOpen: true)
                            ListDivider()
                        }
                        
                        Spacer().frame(height: 50)
                        
                        Group {
                            ListDivider()
                            ListPulldownField(type: .notification, title: "通知", value: createEvent.notificationText)
                            ListDivider()
                        }
                        
                        Spacer().frame(height: 50)
                        
                        ZStack {
                            ColorManager.back
                            
                            VStack {
                                ListDivider()
                                TextEditor(text: $createEvent.detail)
                                    .padding(.horizontal, 10)
                                    .foregroundColor(ColorManager.character)
                                    .font(Font.custom(FontManager.japanese, size: 14))
                                ListDivider()
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 160)
                    }
                }
            }
        }
        .colorScheme(.dark) // FIXME: これだけカラーが反映されない
        .onAppear {
            createEvent.setUpEvent(event: viewSwitcher.targetEvent)
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}

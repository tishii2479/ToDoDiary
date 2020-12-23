//
//  SimplePulldownField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

struct SimplePulldownField: View {
    var type: PulldownType
    var title: String
    @State var value: String = ""
        
    // 開いているかどうか
    @State var isOpen: Bool = false
    @Binding var event: Event?
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                print("tap")
                isOpen.toggle()
            }) {
                ZStack {
                    // 背景
                    SimpleCellBackground()
                    
                    // タイトル
                    SimpleCellTitle(title: title)
                    
                    // 値
                    HStack {
                        Spacer()
                        Text(value)
                            .foregroundColor(ColorManager.lightCharacter)
                            .font(Font.custom(FontManager.japanese, size: 14))
                    }
                    .padding(.horizontal, 10)
                }
            }
            .background(
                ColorManager.back.frame(height: 40)
            )
            
            if isOpen {
                SimpleDivider()
                
                Group {
                    switch type {
                    case .date:
                        SimpleDateField()
                    case .notification:
                        SimpleNotificationField()
                    }
                }
            }
        }
    }
}

struct SimplePulldownField_Previews: PreviewProvider {
    static var previews: some View {
        SimplePulldownField(type: .date, title: "日付", event: .constant(Event.test))
    }
}

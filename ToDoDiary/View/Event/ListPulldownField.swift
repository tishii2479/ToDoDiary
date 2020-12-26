//
//  ListPulldownField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

enum PulldownType {
    case date
    case notification
}

struct ListPulldownField: View {
    var type: PulldownType
    var title: String
    var value: String
        
    // 開いているかどうか
    @State var isOpen: Bool = false
    
    var isAlwaysOpen: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                isOpen.toggle()
            }) {
                ZStack {
                    // 背景
                    ListCellBackground()
                    
                    // タイトル
                    ListCellTitle(title: title)
                    
                    // 値
                    ListCellValue(value: value)
                }
            }
            .background(
                ColorManager.back.frame(height: 40)
            )
            
            if isOpen || isAlwaysOpen {
                ListDivider()
                
                Group {
                    switch type {
                    case .date:
                        ListDateField()
                    case .notification:
                        ListNotificationField()
                    }
                }
            }
        }
    }
}

struct ListPulldownField_Previews: PreviewProvider {
    static var previews: some View {
        ListPulldownField(type: .date, title: "日付", value: "未設定")
    }
}

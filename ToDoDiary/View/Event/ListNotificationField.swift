//
//  ListNotificationField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

struct ListNotificationField: View {
    @EnvironmentObject var createEvent: EventViewModel
    
    var body: some View {
        ZStack {
            // 背景
            Rectangle()
                .fill(ColorManager.back)
                .frame(height: 200)
            
            Picker("通知の選択", selection: $createEvent.notification) {
                Text(NotificationType.none.text).tag(NotificationType.none)
                Text(NotificationType.once.text).tag(NotificationType.once)
            }
            .labelsHidden()
            .padding(-10)   // paddingの打ち消し
        }
    }
}

struct ListNotificationField_Previews: PreviewProvider {
    static var previews: some View {
        ListNotificationField()
    }
}

//
//  ListNotificationField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

struct ListNotificationField: View {
    var body: some View {
        Button(action: {
            print("aa")
        }) {
            ListCellBackground()
        }
    }
}

struct ListNotificationField_Previews: PreviewProvider {
    static var previews: some View {
        ListNotificationField()
    }
}

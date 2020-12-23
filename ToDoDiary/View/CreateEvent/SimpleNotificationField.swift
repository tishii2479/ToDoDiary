//
//  SimpleNotificationField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

struct SimpleNotificationField: View {
    var body: some View {
        Button(action: {
            print("aa")
        }) {
            SimpleCellBackground()
        }
    }
}

struct SimpleNotificationField_Previews: PreviewProvider {
    static var previews: some View {
        SimpleNotificationField()
    }
}

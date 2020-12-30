//
//  UserSetting.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/30.
//

import SwiftUI

class UserSetting: ObservableObject {
    @Published var colorTheme: ColorScheme = .light
    @Published var notification: NotificationType = .none
    
    static let shared = UserSetting()
}

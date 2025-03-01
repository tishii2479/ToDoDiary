//
//  ToDoDiaryApp.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/15.
//

import SwiftUI

@main
struct ToDoDiaryApp: App {
    var body: some Scene {
        // viewswitcherの設定
        WindowGroup {
            MainView()
                .environmentObject(ViewSwitcher.shared)
                .environmentObject(UserSetting.shared)
        }
    }
}

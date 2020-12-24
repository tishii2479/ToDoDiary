//
//  ToDoDiaryApp.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/15.
//

import SwiftUI

@main
struct ToDoDiaryApp: App {
    @State var colorTheme: ColorScheme = .dark
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(ViewSwitcher())
                .environmentObject(CreateEventViewModel())
                .colorScheme(colorTheme)
//                .onTapGesture(count: 2, perform: {  // ダブルタップでカラーテーマを変える（テスト用）
//                    if colorTheme == .dark {
//                        colorTheme = .light
//                    } else {
//                        colorTheme = .dark
//                    }
//                })
        }
    }
}

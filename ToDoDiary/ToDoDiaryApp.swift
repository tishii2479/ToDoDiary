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
                .colorScheme(colorTheme)
                .onTapGesture(count: 2, perform: {
                    if colorTheme == .dark {
                        colorTheme = .light
                    } else {
                        colorTheme = .dark
                    }
                })
        }
    }
}

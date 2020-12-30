//
//  TabBar.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

fileprivate struct TabBarItem: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    var type: ViewType
    
    let imageName: Dictionary<ViewType, String> = [
        .calendar: "calendar",
        .toDoList: "list.bullet.indent",
        .setting: "wrench"
    ]
    
    var body: some View {
        Button(action: {
            viewSwitcher.currentView = type
        }) {
            Image(systemName: imageName[type] ?? "gear")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(ColorManager.image)
        }
    }
}

struct TabBar: View {
    var body: some View {
        ZStack {
            // 背景色
            ColorManager.main
                .edgesIgnoringSafeArea(.bottom)
            
            HStack {
                Spacer()
                TabBarItem(type: .calendar)
                Spacer()
                TabBarItem(type: .toDoList)
                Spacer()
                TabBarItem(type: .setting)
                Spacer()
            }
        }
        .frame(height: 70)
        .shadow(color: ColorManager.shadow, radius: 5, x: 0, y: -5)
        .zIndex(1)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

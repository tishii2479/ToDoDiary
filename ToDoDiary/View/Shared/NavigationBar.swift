//
//  NavigationBar.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct NavigationBar: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    var body: some View {
        ZStack {
            // 背景色
            ColorManager.main
                .edgesIgnoringSafeArea(.top)
        
            // タイトル
            HStack {
                Text(viewSwitcher.navigationTitle ?? "")
                    .font(Font.custom(FontManager.number, size: 24))
                    .bold()
                    .foregroundColor(ColorManager.character)
                Spacer()
                
                trailingItems(viewType: viewSwitcher.currentView)
            }
            .padding(.horizontal, 10)
        }
        .frame(height: 60)
        .shadow(color: ColorManager.shadow, radius: 5, x: 0, y: 5)
        .zIndex(1)
    }
    
    func trailingItems(viewType: ViewType) -> some View {
        return Group {
            switch viewType {
            case .toDoList:
                EditButton()
            default:
                EmptyView()
            }
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}

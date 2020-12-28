//
//  SettingView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI

fileprivate struct SettingHeader: View {
    var title: String = ""
    
    var body: some View {
        HStack {
            Text(title)
                .bold()
                .foregroundColor(ColorManager.character)
                .font(Font.custom(FontManager.japanese, size: 20))
        }
        .listRowBackground(ColorManager.main)
    }
}

fileprivate struct SettingLink: View {
    var title: String = ""
    
    var body: some View {
        NavigationLink(title, destination: EmptyView())
            .foregroundColor(ColorManager.character)
            .font(Font.custom(FontManager.japanese, size: 14))
            .listRowBackground(ColorManager.back)
    }
}

struct SettingView: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    @State var text: String = ""
    
    var body: some View {
        List {
            SettingHeader(title: "タイトル")
                .padding(.top, 20)
                    
            Picker(selection: $viewSwitcher.colorTheme, label:
                    Text("カラーテーマ")
                        .foregroundColor(ColorManager.character)
                        .font(Font.custom(FontManager.japanese, size: 14))
            ) {
                Text("ライト")
                    .foregroundColor(ColorManager.character)
                    .font(Font.custom(FontManager.japanese, size: 14))
                    .tag(ColorScheme.light)
                
                Text("ダーク")
                    .foregroundColor(ColorManager.character)
                    .font(Font.custom(FontManager.japanese, size: 14))
                    .tag(ColorScheme.dark)
            }
            .listRowBackground(ColorManager.back)
            
            SettingLink(title: "設定")
            SettingLink(title: "設定")
            
            SettingHeader(title: "タイトル")
                .padding(.top, 40)
            
            SettingLink(title: "設定")
            SettingLink(title: "設定")
            SettingLink(title: "設定")
            SettingLink(title: "設定")
        }
        .onAppear {
            // リストの色の設定
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().backgroundColor = UIColor(ColorManager.main)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

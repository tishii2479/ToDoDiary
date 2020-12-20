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
        .listRowBackground(ColorManager.back)
    }
}

fileprivate struct SettingLink: View {
    var title: String = ""
    
    var body: some View {
        NavigationLink(title, destination: EmptyView())
            .foregroundColor(ColorManager.character)
            .font(Font.custom(FontManager.japanese, size: 14))
            .listRowBackground(ColorManager.back)
            .frame(height: 40)
    }
}

struct SettingView: View {
    @State var text: String = ""
    
    var body: some View {
        // リストの色の設定
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor(ColorManager.back)
        return NavigationView {
            List {
                SettingHeader(title: "タイトル")
                    .padding(.top, 20)
                        
                SettingLink(title: "設定")
                SettingLink(title: "設定")
                
                SettingHeader(title: "タイトル")
                    .padding(.top, 40)
                
                SettingLink(title: "設定")
                SettingLink(title: "設定")
                SettingLink(title: "設定")
                SettingLink(title: "設定")
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .colorScheme(.dark)
    }
}

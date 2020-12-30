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
        NavigationLink(title, destination: SettingTextView())
            .foregroundColor(ColorManager.character)
            .font(Font.custom(FontManager.japanese, size: 14))
            .listRowBackground(ColorManager.back)
            .navigationBarTitle("", displayMode: .inline)
    }
}

struct SettingView: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    @EnvironmentObject var userSetting: UserSetting
    @State var text: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header:
                    SettingHeader(title: "ユーザ設定")
                            .padding(.top, 20)
                ) {
                    Picker(selection: $userSetting.colorTheme, label:
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
                            .navigationBarTitle("", displayMode: .inline)
                    }
                    .listRowBackground(ColorManager.back)
                    
                    Picker(selection: $userSetting.notification, label:
                            Text("通知")
                                .foregroundColor(ColorManager.character)
                                .font(Font.custom(FontManager.japanese, size: 14))
                    ) {
                        Text("なし")
                            .foregroundColor(ColorManager.character)
                            .font(Font.custom(FontManager.japanese, size: 14))
                            .tag(NotificationType.none)
                        
                        Text("一回のみ")
                            .foregroundColor(ColorManager.character)
                            .font(Font.custom(FontManager.japanese, size: 14))
                            .tag(NotificationType.once)
                            .navigationBarTitle("", displayMode: .inline)
                    }
                    .listRowBackground(ColorManager.back)
                }
                
                Section(header:
                    SettingHeader(title: "このアプリについて")
                            .padding(.top, 20)
                ) {
                    SettingLink(title: "利用規約")
                    SettingLink(title: "プライバシーポリシー")
                    SettingLink(title: "バージョン")
                    SettingLink(title: "問い合わせ")
                }
                
            }
            .listStyle(GroupedListStyle())
            .onAppear {
                viewSwitcher.setNavigationTitle(title: "設定")
                
                // リストの色の設定
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().backgroundColor = UIColor(ColorManager.main)
                UINavigationBar.appearance().backgroundColor = UIColor(Color.clear)
            }
            .navigationTitle("")
        }
//        .padding(.top, -44)   // hide navigationbar
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

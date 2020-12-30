//
//  SettingTextView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/30.
//

import SwiftUI

struct SettingTextView: View {
    var body: some View {
        ZStack {
            ColorManager.back
            
            ScrollView {
                Text("asdf;lkasjdf;alskjf")
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.custom(FontManager.japanese, size: 14))
                    .foregroundColor(ColorManager.character)
                    .padding(20)
            }
        }
    }
}

struct SettingTextView_Previews: PreviewProvider {
    static var previews: some View {
        SettingTextView()
    }
}

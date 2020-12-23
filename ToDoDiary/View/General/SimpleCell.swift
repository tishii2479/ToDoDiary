//
//  SimpleCell.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

struct SimpleCellTitle: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(ColorManager.character)
                .font(Font.custom(FontManager.japanese, size: 14))
                .bold()
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}

// テーブルのセルの背景用
struct SimpleCellBackground: View {
    var body: some View {
        Rectangle()
            .fill(ColorManager.back)
            .frame(height: 40)
    }
}

struct SimpleCellBackground_Previews: PreviewProvider {
    static var previews: some View {
        SimpleCellBackground()
    }
}

//
//  ListCell.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

struct ListCellValue: View {
    var value: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(value)
                .foregroundColor(ColorManager.character)
                .font(Font.custom(FontManager.japanese, size: 14))
        }
        .padding(.horizontal, 10)
        .frame(maxWidth: UIScreen.main.bounds.width)
    }
}

struct ListCellTitle: View {
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
        .frame(width: UIScreen.main.bounds.width, height: 40)
    }
}

// テーブルのセルの背景用
struct ListCellBackground: View {
    var body: some View {
        Rectangle()
            .fill(ColorManager.back)
            .frame(height: 40)
    }
}

struct ListCellBackground_Previews: PreviewProvider {
    static var previews: some View {
        ListCellBackground()
    }
}

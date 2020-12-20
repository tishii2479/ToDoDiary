//
//  CalendarEventLabel.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI

struct CalendarEventLabel: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(ColorManager.back)
                .frame(height: 15)
                .overlay(   // 丸みのついた枠線
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.red, lineWidth: 1)
                )
                .padding(.horizontal, 2)
            
            Text("イベント")
                .font(Font.custom(FontManager.japanese, size: 10))
                .foregroundColor(ColorManager.character)
                .lineLimit(1)
        }
    }
}

struct CalendarEventLabel_Previews: PreviewProvider {
    static var previews: some View {
        CalendarEventLabel()
    }
}

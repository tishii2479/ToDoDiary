//
//  DayBar.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/26.
//

import SwiftUI

struct DayBar: View {
    let days: [String] = ["日", "月", "火", "水", "木", "金", "土"]
    
    var body: some View {
        HStack(alignment: .center) {
            ForEach(0 ..< days.count) { i in
                Spacer()
                Text(days[i])
                    .font(Font.custom(FontManager.japanese, size: 14))
                    .foregroundColor(i == 0 ? ColorManager.redCharacter : ColorManager.character)
                    .frame(height: 20)
                Spacer()
            }
        }
        .frame(height: 20)
        .background(ColorManager.back)
    }
}

struct DayBar_Previews: PreviewProvider {
    static var previews: some View {
        DayBar()
    }
}

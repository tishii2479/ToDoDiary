//
//  CalendarDateDetail.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI

fileprivate struct DetailEventLabel: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("9:00 - 13:00")
                .foregroundColor(ColorManager.character)
                .font(Font.custom(FontManager.number, size: 14))
                .frame(minWidth: 100, alignment: .trailing)
            
            Color.red.frame(width: 1)
                .padding(.horizontal, 10)
            
            Text("アルバイト")
                .foregroundColor(ColorManager.character)
                .font(Font.custom(FontManager.japanese, size: 14))
            
            Spacer()
        }
        .padding(.vertical, 5)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
    }
}

struct CalendarDateDetail: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack {
                Text("2020/1/1（木）")
                    .foregroundColor(ColorManager.character)
                    .font(Font.custom(FontManager.number, size: 14))
                Spacer()
            }
            .padding(.horizontal, 10)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
            .background(ColorManager.main)
            
            ScrollView {
                VStack (spacing: 0) {
                    DetailEventLabel()
                    DetailEventLabel()
                    DetailEventLabel()
                    DetailEventLabel()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 200)
            .background(ColorManager.back)
        }
    }
}

struct CalendarDateDetail_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDateDetail()
    }
}

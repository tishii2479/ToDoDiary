//
//  ColorPalette.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

fileprivate struct ColorTile: View {
    var eventColor: EventColor
    @Binding var selectedColor: EventColor
    
    var body: some View {
        Button(action: {
            if selectedColor == eventColor {
                selectedColor = .none
            } else {
                selectedColor = eventColor
            }
        }) {
            ZStack {
                // 選択されていたら枠線がつく
                if eventColor == selectedColor {
                    Circle()
                        .fill(ColorManager.denseBorder)
                        .frame(width: 30, height: 30)
                }
                
                Circle()
                    .fill(eventColor.color)
                    .frame(width: 24, height: 24)
                    .shadow(color: ColorManager.shadow, radius: 5, x: 0, y: 5)
                    .padding(3) // 枠線の大きさと同じにすることで位置がずれないように
            }
        }
    }
}

struct ColorPalette: View {
    @Binding var selectedColor: EventColor
    
    var body: some View {
        HStack {
            ForEach(EventColor.list, id: \.self) { color in
                Spacer()
                ColorTile(eventColor: color, selectedColor: $selectedColor)
                Spacer()
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 40)
    }
}

struct ColorPalette_Previews: PreviewProvider {
    static var previews: some View {
        ColorPalette(selectedColor: .constant(.none))
    }
}

//
//  DayBar.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/17.
//

import SwiftUI

struct DayBar: View {
    let days: [String] = ["日", "月", "火", "水", "木", "金", "土"]
    
    var body: some View {
        HStack {
            ForEach(0 ..< days.count) { i in
                Spacer()
                Text(days[i])
                    .font(.callout)
                Spacer()
            }
        }
        .frame(height: 30)
        .background(ColorManager.back)
    }
}

struct DayBar_Previews: PreviewProvider {
    static var previews: some View {
        DayBar()
    }
}

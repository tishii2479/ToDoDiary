//
//  MonthlyCell.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/19.
//

import SwiftUI

struct CalendarCell: View {
    var index: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("\(index)")
                    .font(.callout)
                    .padding(5)
                Spacer()
            }
            Spacer()
        }
        .frame(width: 60, height: 140)
        .background(ColorManager.calendar1)
        .border(ColorManager.calendarBorder, width: 1)
    }
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCell()
    }
}

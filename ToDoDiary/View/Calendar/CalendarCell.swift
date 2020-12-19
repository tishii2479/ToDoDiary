//
//  MonthlyCell.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/19.
//

import SwiftUI

struct CalendarCell: View {
    var date: Date
    
    init (index: Int) {
        self.date = CalendarManager.shared.getDateFromIndex(index: index)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(CalendarManager.shared.formatForCalendar(date: self.date))")
                    .font(.callout)
                    .padding(5)
                Spacer()
            }
            Spacer()
        }
        .frame(width: 60, height: 140)
        .background(
            Group {
                if (CalendarManager.shared.isOddMonth(date: self.date)) {
                    ColorManager.calendar1
                } else {
                    ColorManager.calendar2
                }
            }
        )
        .border(ColorManager.calendarBorder, width: 1)
    }
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCell(index: 0)
    }
}

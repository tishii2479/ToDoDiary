//
//  MonthlyCell.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/19.
//

import SwiftUI

fileprivate struct CalendarEventLabel: View {
    var event: Event
    
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
            
            Text(event.title)
                .font(Font.custom(FontManager.japanese, size: 10))
                .foregroundColor(ColorManager.character)
                .lineLimit(1)
        }
    }
}

struct CalendarCell: View {
    var date: Date
    var events: [Event] = []
    
    init (index: Int) {
        self.date = CalendarManager.shared.getDateFromIndex(index: index)
        
        if let _events = CalendarManager.shared.getEventArrayFromDate(date: CalendarManager.shared.formatFullDate(date: self.date)) {
            events = _events
        }
     }
    
    var body: some View {
        VStack(spacing: 7) {
            // 日付ラベル
            HStack {
                Text("\(CalendarManager.shared.formatDateForCalendar(date: self.date))")
                    .font(Font.custom(FontManager.number, size: 18))
                    .bold()
                    .foregroundColor(ColorManager.character)
                    .padding([.top, .leading], 5)
                Spacer()
            }
            
            // イベントラベル
            ForEach(0 ..< events.count, id: \.self) { index in
                CalendarEventLabel(event: events[index])
            }
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width / 7, height: 140)
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

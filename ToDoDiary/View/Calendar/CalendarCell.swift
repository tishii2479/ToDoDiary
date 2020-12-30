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
                        .stroke(event.eventColor, lineWidth: 1)
                )
                .padding(.horizontal, 2)
            
            Text(event.title)
                .font(Font.custom(FontManager.japanese, size: 10))
                .foregroundColor(ColorManager.character)
                .lineLimit(1)   // FIXME: ...省略をclip、textBreakMode
        }
    }
}

struct CalendarCell: View {
    @ObservedObject var calendar: CalendarViewModel
    var date: Date = Date()
    var events: [Event] = []
    
    init (date: Date, calendar: CalendarViewModel) {
        self.calendar = calendar
        self.date = date
        let dateStr: String = CalendarManager.shared.formatFullDate(date: self.date)
        
        if let _events = EventManager.shared.getEventArrayFromDate(date: dateStr) {
            events = _events
        }
     }
    
    var body: some View {
        ZStack {
            VStack {
                // 日付ラベル
                HStack {
                    Text("\(CalendarManager.shared.formatDateForCalendar(date: self.date))")
                        .font(Font.custom(FontManager.number, size: 18))
                        .bold()
                        .foregroundColor(ColorManager.character)
                        .padding([.top, .leading], 5)
                    Spacer()
                }
                
                Spacer()
            }
            
            VStack(spacing: 7) {
                // イベントラベル
                ForEach(0 ..< min(3, events.count), id: \.self) { index in
                    // 削除のチェック
                    if events[index].isInvalidated == false {
                        CalendarEventLabel(event: events[index])
                    }
                }
                
                // TODO: イベントの数が多い時は省略していることを表現する
                if events.count > 3 {
                    
                }
                
                Spacer()
            }
            .padding(.top, 40)
            .frame(maxHeight: 100)
        }
        .frame(width: UIScreen.main.bounds.width / 7, height: 100)
        .background(
            Group {
                if CalendarManager.shared.isTargetDate(date: self.date, year: calendar.nowYear, month: calendar.nowMonth) {
                    if CalendarManager.shared.isOddMonth(date: self.date) {
                        ColorManager.calendar1
                    } else {
                        ColorManager.calendar2
                    }
                } else {
                    ColorManager.unableBack
                }
            }
        )
        .border(ColorManager.calendarBorder, width: 1)
    }
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCell(date: Date(), calendar: CalendarViewModel())
    }
}

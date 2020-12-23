//
//  MonthlyView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

fileprivate struct DayBar: View {
    let days: [String] = ["日", "月", "火", "水", "木", "金", "土"]
    
    var body: some View {
        HStack(alignment: .center) {
            ForEach(0 ..< days.count) { i in
                Spacer()
                Text(days[i])
                    .font(Font.custom(FontManager.japanese, size: 14))
                    .foregroundColor(i == 0 ? ColorManager.redCharacter : ColorManager.character)
                    .frame(height: 20)
                    .padding(.top, 15)
                Spacer()
            }
        }
        .frame(height: 20)
        .background(ColorManager.back)
    }
}

struct CalendarView: View {
    
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    @ObservedObject var calendar: CalendarViewModel = CalendarViewModel()
    
    var body: some View {
        VStack {
            // 曜日表示のバー
            DayBar()
            
            // カレンダー
            ScrollViewReader { (proxy: ScrollViewProxy) in
                ZStack {
                    // 背景色
                    ColorManager.calendarBorder
                    
                    // カレンダーコンテンツ
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 300)), count: 7), spacing: 0) {
                            ForEach((-49 ... 48), id: \.self) { index in
                                Button(action: {
                                    calendar.selectIndex(index: index)
                                }) {
                                    CalendarCell(index: index).id(index)
                                }
                            }
                        }
                        .padding(.horizontal, 4)       // 表示がはみ出すのを防ぐ
                    }
                    
                    // 日時イベント詳細ウィンドウ
                    if calendar.isShowingDetail {
                        CalendarDateDetail(calendar: calendar)
                    }
                    
// proxy.scrollTo(0, anchor: .center)
                    
                    CreateEventButton()
                }
            }
            .sheet(isPresented: $viewSwitcher.isShowingModal) {
                CreateEventView()
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

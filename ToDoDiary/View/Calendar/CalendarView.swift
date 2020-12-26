//
//  MonthlyView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    @ObservedObject var calendar: CalendarViewModel = CalendarViewModel()
    
    var body: some View {
        VStack {
            // 曜日表示のバー
            DayBar()
                .padding(.top, 15)
            
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
                    
                    CreateEventButton()
                }
            }
            .sheet(isPresented: $viewSwitcher.isShowingModal) {
                EventView()
                    .environmentObject(EventViewModel())
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

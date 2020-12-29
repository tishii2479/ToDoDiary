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
    
    @State private var scrollOffset: CGFloat = 0
    
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
                        ZStack {
                            LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 300)), count: 7), spacing: 0) {
                                ForEach((-7 ..< 378), id: \.self) { index in
                                    Button(action: {
                                        calendar.selectIndex(index: index)
                                    }) {
                                        CalendarCell(date: calendar.getDateFromIndex(index: index)).id(index)
                                    }
                                }
                            }
                            .padding(.horizontal, 4)       // 表示がはみ出すのを防ぐ
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            calendar.nextYear()
                            proxy.scrollTo(calendar.today)
                        }) {
                            Text("next")
                        }
                        
                        Button(action: {
                            calendar.lastYear()
                            proxy.scrollTo(calendar.today)
                        }) {
                            Text("last")
                        }
                    }
                    
                    // 日時イベント詳細ウィンドウ
                    if calendar.isShowingDetail {
                        CalendarDateDetail(calendar: calendar)
                    }
                    
                    CreateEventButton()
                }
                .onAppear {
                    proxy.scrollTo(calendar.today)
                }
            }
            .sheet(isPresented: $viewSwitcher.isShowingModal) {
                EventView()
                    .environmentObject(EventViewModel(content: .event))
                    .colorScheme(viewSwitcher.colorTheme) // FIXME: これだけカラーが反映されない
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

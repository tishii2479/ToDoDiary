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
    
    @State private var scrollOffset: CGFloat = 0 {
        didSet {
            print(scrollOffset)
        }
    }
    
    private let LIMIT: Int = 210
    
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
                    TrackableScrollView(.vertical, showIndicators: false, contentOffset: $scrollOffset, calendarViewModel: calendar) {
                        ZStack {
                            LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 300)), count: 7), spacing: 0) {
                                ForEach((-LIMIT ..< LIMIT), id: \.self) { index in
                                    Button(action: {
                                        calendar.selectIndex(index: index)
                                    }) {
                                        CalendarCell(index: index).id(index)
                                    }
                                }
                            }
                            .padding(.horizontal, 4)       // 表示がはみ出すのを防ぐ
                        }
                    }
                    
                    // 日時イベント詳細ウィンドウ
                    if calendar.isShowingDetail {
                        CalendarDateDetail(calendar: calendar)
                    }
                    
                    CreateEventButton()
                }
                .onAppear {
                    proxy.scrollTo(0)
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

//
//  MonthlyView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        ZStack {
            ColorManager.back
                .edgesIgnoringSafeArea(.all)
            
            ScrollViewReader { (proxy: ScrollViewProxy) in
                ZStack {
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 300)), count: 7), spacing: 0, pinnedViews: .sectionHeaders) {
                            Section(header: DayBar()) {
                                ForEach((-100...100), id: \.self) { index in
                                    CalendarCell(index: index)
                                }
                            }
                        }
                    }
                    
                    Button("Scroll to bottom") {
                        withAnimation {
                            proxy.scrollTo(0, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

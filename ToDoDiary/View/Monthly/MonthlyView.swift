//
//  MonthlyView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct MonthlyView: View {
    var body: some View {
        ZStack {
            Color("Back")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: 50, maximum: 100)), count: 7), pinnedViews: .sectionHeaders) {
                    Section(header: Text("Header")) {
                        ForEach((1...1000), id: \.self) { index in
                            Text("\(index)")
                                .frame(width: 60, height: 100)
                                .background(Color("Calendar1"))
                                .border(Color("CalendarBorder"), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
            }
        }
    }
}

struct MonthlyView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyView()
    }
}

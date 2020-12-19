//
//  NavigationBar.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        ZStack {
            ColorManager.main
                .edgesIgnoringSafeArea(.top)
        
            HStack {
                Text("2021/1")
                    .font(.largeTitle)
                    .padding(.leading, 10)
                Spacer()
            }
        }
        .frame(height: 60)
        .shadow(color: ColorManager.shadow, radius: 5, x: 0, y: 5)
        .zIndex(1)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}

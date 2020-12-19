//
//  TabBar.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        ZStack {
            ColorManager.main
                .edgesIgnoringSafeArea(.bottom)
        }
        .frame(height: 70)
        .shadow(color: ColorManager.shadow, radius: 5, x: 0, y: -5)
        .zIndex(1)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

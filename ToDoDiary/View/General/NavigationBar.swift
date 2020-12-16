//
//  NavigationBar.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        VStack {
            Color("MainColor")
                .edgesIgnoringSafeArea(.bottom)
                .frame(height: 50)
                .shadow(color: Color.black, radius: 5, x: 0, y: 5)
            Spacer()
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}

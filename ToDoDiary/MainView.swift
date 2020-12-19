//
//  MainView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
            CurrentView()
            TabBar()
        }
        .background(ColorManager.back)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .colorScheme(.light)
    }
}

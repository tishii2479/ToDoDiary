//
//  MainView.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/16.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    @ObservedObject var keyboard = KeyboardResponder()
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
            CurrentView()
            
            if keyboard.isShowing == false {
                TabBar()
            }
        }
        .background(ColorManager.back)
        .colorScheme(viewSwitcher.colorTheme)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

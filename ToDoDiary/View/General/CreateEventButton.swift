//
//  CreateEventButton.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/20.
//

import SwiftUI

struct CreateEventButton: View {
    @EnvironmentObject var viewSwitcher: ViewSwitcher
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    viewSwitcher.showModal()
                }) {
                    ZStack {
                        Circle()
                            .fill(ColorManager.main)
                            .frame(width: 60, height: 60)
                            .shadow(color: ColorManager.shadow, radius: 5, x: 0, y: 5)
                            
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(ColorManager.image)
                    }
                }
                .accessibility(identifier: "CreateEventButton")
            }
        }
        .padding(.trailing, 20)
        .padding(.bottom, 30)
    }
}

struct CreateEventButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventButton()
    }
}

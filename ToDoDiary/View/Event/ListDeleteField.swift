//
//  ListDeleteField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/26.
//

import SwiftUI

struct ListDeleteField: View {
    @EnvironmentObject var createEvent: EventViewModel
    
    var body: some View {
        Button(action: {
            createEvent.deleteEvent()
        }) {
            Text("削除する")
                .foregroundColor(ColorManager.redCharacter)
                .font(Font.custom(FontManager.japanese, size: 14))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
                .padding(.horizontal, 10)
                .background(ColorManager.back)
        }
    }
}

struct ListDeleteField_Previews: PreviewProvider {
    static var previews: some View {
        ListDeleteField()
    }
}

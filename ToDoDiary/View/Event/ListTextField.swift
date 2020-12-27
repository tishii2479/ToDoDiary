//
//  ListTextField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

struct ListTextField: View {
    @Binding var value: String
    var placeHolder: String
    
    var body: some View {
        TextField(placeHolder, text: $value)
            .foregroundColor(ColorManager.character)
            .font(Font.custom(FontManager.japanese, size: 14))
            .padding(.horizontal, 10)
            .frame(width: UIScreen.main.bounds.width, height: 40)
            .background(ColorManager.back)
    }
}

struct ListTextField_Previews: PreviewProvider {
    static var previews: some View {
        ListTextField(value: .constant("aa"), placeHolder: "Place holder")
    }
}

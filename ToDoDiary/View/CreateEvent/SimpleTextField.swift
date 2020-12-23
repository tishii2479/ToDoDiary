//
//  SimpleTextField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

struct SimpleTextField: View {
    @Binding var value: String
    var placeHolder: String
    
    var body: some View {
        TextField(placeHolder, text: $value)
            .foregroundColor(ColorManager.character)
            .font(Font.custom(FontManager.japanese, size: 14))
            .frame(height: 40)
            .padding(.horizontal, 10)
            .background(ColorManager.back)
    }
}

struct SimpleTextField_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTextField(value: .constant("aa"), placeHolder: "Place holder")
    }
}

//
//  ListToggleField.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/30.
//

import SwiftUI

struct ListToggleField: View {
    var title: String
    @Binding var isOn: Bool
    var body: some View {
        ZStack {
            // 背景
            ListCellBackground()
            
            // タイトル
            ListCellTitle(title: title)
            
            
            HStack {
                Spacer()
                Toggle("ToDoに追加するか", isOn: $isOn)
                    .labelsHidden()
            }
            .padding(.trailing, 10)
        }
    }
}

struct ListToggleField_Previews: PreviewProvider {
    static var previews: some View {
        ListToggleField(title: "タイトル", isOn: Binding.constant(false))
    }
}

//
//  ListDivider.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

struct ListDivider: View {
    var body: some View {
        Divider()
            .background(ColorManager.border)
    }
}

struct ListDivider_Previews: PreviewProvider {
    static var previews: some View {
        ListDivider()
    }
}

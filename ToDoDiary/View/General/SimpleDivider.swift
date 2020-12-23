//
//  SimpleDivider.swift
//  ToDoDiary
//
//  Created by Tatsuya Ishii on 2020/12/23.
//

import SwiftUI

struct SimpleDivider: View {
    var body: some View {
        Divider()
            .background(ColorManager.border)
    }
}

struct SimpleDivider_Previews: PreviewProvider {
    static var previews: some View {
        SimpleDivider()
    }
}

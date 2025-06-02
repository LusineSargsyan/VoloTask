//
//  IconTitleView.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import SwiftUI

struct IconTitleRow: View {
    let iconName: String
    let text: String
    let textWeight: Font.Weight

    var body: some View {
        HStack(spacing: 6) {
            Image(iconName)
                .foregroundColor(.white)
            Text(text)
                .foregroundColor(.white)
                .fontWeight(textWeight)
        }
    }
}

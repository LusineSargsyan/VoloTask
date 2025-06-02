//
//  RoundedBorderButtonStyle.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import SwiftUI

struct RoundedBorderButtonStyle: ButtonStyle {
    var foregroundColor: Color = .white
    var backgroundColor: Color = .clear
    var borderColor: Color = .white
    var borderColorOpacity: Double = 0.16
    var cornerRadius: CGFloat = 8
    var lineWidth: CGFloat = 2

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(foregroundColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(borderColor.opacity(borderColorOpacity),
                                    lineWidth: lineWidth)
                    )
            )
            .contentShape(Rectangle())
    }
}

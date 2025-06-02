//
//  GradientModifer.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import SwiftUI

struct GradientModifer: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.darkBlueBackgound, .lightBlueBackgound]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .edgesIgnoringSafeArea(.all)

            content
        }
    }
}

extension View {
    func applyGradiendBackground() -> some View {
        self.modifier(GradientModifer())
    }
}

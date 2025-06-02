//
//  EmptyView.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack {
            Spacer()

            Image ("empty")
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.16))
                )
                .padding(.bottom, 16)


            Text("You don’t have any timesheets.")
                .font(.system(size: 20, weight: .bold))

            Spacer()
        }
        .foregroundColor(.white)
    }
}

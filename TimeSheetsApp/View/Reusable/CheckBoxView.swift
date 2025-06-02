//
//  CheckBoxView.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isChecked: Bool

    var body: some View {
        HStack {
            Image(isChecked ? "select" : "deselect")
                .onTapGesture {
                    isChecked.toggle()
                }

            Text("Make Favorite")
                .foregroundColor(.white)

            Spacer()
        }
    }
}

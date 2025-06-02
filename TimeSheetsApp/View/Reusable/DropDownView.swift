//
//  DropDownView.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import SwiftUI

struct DropDownView: View {
    @Binding var type: DropDownItemType?
    @Binding var selectedOprtion: String?

    var item: DropDownItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: {
                withAnimation {
                    type = (type == item.type) ? nil : item.type
                }
            }) {
                HStack {
                    Text(selectedOprtion ?? item.title)
                        .font(.headline)
                    Spacer()
                    Image(systemName: type == item.type ? "chevron.up" : "chevron.down")
                }
            }
            .padding(.all, 16)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white.opacity(0.16), lineWidth: 2)
                    )
            )
            .padding(.horizontal, 16)

            if type == item.type {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(item.options, id: \.self) { option in
                        Button {
                            selectedOprtion = option
                        } label: {
                            HStack {
                                Text(option)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.all, 8)

                                if selectedOprtion == option {

                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                        .padding(.trailing, 8)
                                }
                            }
                        }

                        Divider()
                            .background(Color.gray)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white.opacity(0.16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white.opacity(0.16), lineWidth: 2)
                        )
                )
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .animation(.easeInOut(duration: 0.1), value: type)
                .transition(.opacity)

            }
        }
    }
}

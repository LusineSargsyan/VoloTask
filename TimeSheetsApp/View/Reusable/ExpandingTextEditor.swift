//
//  ExpandingTextEditor.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import SwiftUI

struct ExpandingTextEditor: View {
    @FocusState private var isFocused: Bool
    @State private var dynamicHeight: CGFloat = 40
    @Binding var text: String

    var placeholder: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white.opacity(0.4))
                    .padding(.vertical, 12)
                    .padding(.horizontal, 8)
            }

            TextEditor(text: $text)
                .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
                .padding(8)
                .background(Color.clear)
                .foregroundColor(.white)
                .scrollContentBackground(.hidden)
                .focused($isFocused)
                .onChange(of: text) {
                    recalculateHeight()
                }
                .onAppear {
                    recalculateHeight()
                }
                .keyboardType(.default)
                .submitLabel(.return)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Clear") {
                            text = ""
                        }
                        Spacer()
                        Button("Done") {
                            isFocused = false
                        }
                    }
                }
        }
    }

    // TODO: - change with dynamic values if time left
    private func recalculateHeight() {
        let text = self.text.isEmpty ? " " : self.text
        let font = UIFont.preferredFont(forTextStyle: .body)
        let width = UIScreen.main.bounds.width - 32 // assuming horizontal padding

        let size = CGSize(width: width - 16, height: .infinity)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let boundingBox = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        let height = max(40, ceil(boundingBox.height) + 24) // padding adjustment
        dynamicHeight = height
    }
}

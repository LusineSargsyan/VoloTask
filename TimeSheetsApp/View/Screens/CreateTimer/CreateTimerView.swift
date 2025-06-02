//
//  CreateTimerView.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import SwiftUI
import SwiftData

struct CreateTimerView: View {
    let dropdownItem: [DropDownItem] = [
        DropDownItem(type: .project, options: ["Project 1", "Project 2", "Project 3"]),
        DropDownItem(type: .task, options: ["Task 1", "Task 2", "Task 3"])
    ]

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query private var projects: [Project]

    @State private var expandedDropDownType: DropDownItemType? = nil
    @State private var text = ""
    @State private var height: CGFloat = 44

    @State private var selectedProjectValue: String?
    @State private var selectedTaskValue: String?
    @State private var isFavorite: Bool = false

    @State private var showAlert: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TopBarView(title: "Create Timer")

            ForEach(dropdownItem) { item in
                DropDownView(
                    type: $expandedDropDownType,
                    selectedOprtion: item.type == .project ? $selectedProjectValue : $selectedTaskValue,
                    item: item
                )
            }

            ExpandingTextEditor(
                text: $text, placeholder: "Description"
            )
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.16), lineWidth: 2)
            )
            .padding(.horizontal, 16)

            CheckBoxView(isChecked: $isFavorite)
                .padding(.top, 16)
                .padding(.horizontal, 16)

            Spacer()

            Button(action: {
                addItem()
            }) {
                Text("Create Timer")
                    .fontWeight(.regular)
            }
            .buttonStyle(RoundedBorderButtonStyle())
            .padding(.horizontal, 16)

        }
        .applyGradiendBackground()
        .navigationBarHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text("\(GenericError.dataSaving)")
            )
        }
    }

    private func addItem() {
        guard let selectedProjectValue,
              let selectedTaskValue else { return }

        let project: Project?

        if let proj = projects.first(where: { project in
            project.name == selectedProjectValue
        }) {
            project = proj
        } else {
            project = Project(name: selectedProjectValue)
        }

        let newItem = Task(
            title: selectedTaskValue,
            isFavorite: isFavorite,
            project: project
        )
        modelContext.insert(newItem)
        do {
            try modelContext.save()
            dismiss()
        } catch {
            showAlert = true
        }
    }
}

struct CreateTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTimerView()
    }
}

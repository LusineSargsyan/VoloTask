//
//  TimerCardView.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import SwiftUI
import SwiftData

struct TimerCardView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showAlert: Bool = false

    let task: Task
    let onButtonStateChanged: () -> Void

    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 4)
                .cornerRadius(2)

            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 8) {
                    IconTitleRow(
                        iconName: task.isFavorite ? "favorite.fill" : "favorite",
                        text: task.project?.name ?? "N/A",
                        textWeight: .bold
                    )
                    IconTitleRow(
                        iconName: "project",
                        text: task.title,
                        textWeight: .regular
                    )
                    IconTitleRow(
                        iconName: "deadline",
                        text: "Deadline \(task.deadline.toMMDDYYYY())",
                        textWeight: .regular
                    )
                }
            }

            Spacer()

            Button {
                playPauseAction(task: task)
            } label: {
                HStack(spacing: 8) {
                    Text(task.seconds.formatHHMMSS())
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)

                    Image(systemName: task.isInProgress ? "pause" : "play.fill")
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(task.isInProgress ? Color.white : Color.white.opacity(0.5))
                .clipShape(Capsule())
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.16))
        )
        .padding(.horizontal, 0)
        .buttonStyle(.borderless)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text("\(GenericError.dataSaving)")
            )
        }
    }

    private func playPauseAction(task: Task) {
        task.isInProgress.toggle()

        do {
            try modelContext.save()
        } catch {
            showAlert = true
        }

        onButtonStateChanged()
    }
}

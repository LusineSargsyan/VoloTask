//
//  TimersListView.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import SwiftUI
import SwiftData

enum ScreenRoute: Hashable {
    case createTimer
    case timerDetail
}

struct TimersListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var path = NavigationPath()
    @Query private var tasks: [Task]
    @StateObject private var timeManagerHolder: TimerManagerWrapper = TimerManagerWrapper()
    @State private var showAlert: Bool = false

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                HStack {
                    Text("Timesheets")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        path.append(ScreenRoute.createTimer)
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .padding(.all, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white.opacity(0.16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white.opacity(0.16), lineWidth: 2)
                                    )
                            )
                    }
                }
                .foregroundColor(.white)
                .padding()
                if tasks.isEmpty {
                    EmptyView()
                } else {
                    HStack {
                        Text("You have \(tasks.count) timers.")
                            .fontWeight(.bold)
                            .padding(.leading, 8)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding(.bottom, 8)
                }
                List {
                    ForEach(tasks) { task in
                        TimerCardView(task: task) {
                            stopTimerIfNeeded()
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            path.append(ScreenRoute.timerDetail)
                        }
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)

                Spacer()
            }
            .navigationDestination(for: ScreenRoute.self) { route in
                switch route {
                    case .createTimer:
                        CreateTimerView()
                    case .timerDetail:
                        Text("Sorry no time left :(")
                            .applyGradiendBackground()
                }
            }
            .applyGradiendBackground()
        }
        .onAppear() {
            runTimerIfNeeded()
        }
        .onChange(of: timeManagerHolder.manager?.timerManagerError) { _, newValue in
            DispatchQueue.main.async {
                showAlert = newValue != nil
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text("\(timeManagerHolder.manager?.timerManagerError?.description ?? "")"),
                dismissButton: .default(Text("Ok")) {
                    timeManagerHolder.manager?.timerManagerError = nil
                }
            )
        }
    }

    private func runTimerIfNeeded() {
        if timeManagerHolder.manager == nil {
            timeManagerHolder.manager = TimerManager(modelContext: modelContext)
            timeManagerHolder.startGlobalTimer()
        }
    }

    private func stopTimerIfNeeded() {
        let anyInProgreesTask = tasks.first { $0.isInProgress }

        if anyInProgreesTask == nil {
            timeManagerHolder.stopGlobalTimer()
        } else {
            timeManagerHolder.startGlobalTimer()
        }
    }
}

#Preview {
    TimersListView()
        .modelContainer(for: Task.self, inMemory: true)
        .modelContainer(for: Project.self, inMemory: true)
}

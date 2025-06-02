//
//  TimerManager.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import SwiftUI
import SwiftData

enum GenericError: String, Error, CustomStringConvertible {
    case persistedDataMissing
    case dataSaving

    var description: String {
        switch self {
            case .persistedDataMissing:
                "Persisted data fetching error"
            case .dataSaving:
                "Persisted data saving error"
        }
    }
}

final class TimerManager: ObservableObject {
    private var timer: DispatchSourceTimer?
    private let queue = DispatchQueue(label: "com.myapp.timer", qos: .userInitiated)
    private var modelContext: ModelContext

    @Published var timerManagerError: GenericError?

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func startGlobalTimer() {
        queue.sync { [weak self] in
            guard let self, timer == nil else { return }

            self.timer = DispatchSource.makeTimerSource(queue: self.queue)
            self.timer?.schedule(deadline: .now(), repeating: 1.0)

            self.timer?.setEventHandler { [weak self] in
                self?.tick()
            }

            self.timer?.resume()
        }
    }

    private func tick() {
        do {
            let descriptor = FetchDescriptor<Task>(
                predicate: #Predicate { $0.isInProgress == true }
            )

            let context = ModelContext(modelContext.container) // creating background context

            do {
                let tasks = try context.fetch(descriptor)

                for task in tasks {
                    task.seconds += 1
                }

                do {
                    try context.save()
                } catch {
                    timerManagerError = GenericError.dataSaving
                }
            } catch {
                timerManagerError = GenericError.persistedDataMissing
            }
        }
    }

    func stopGlobalTimer() {
        queue.sync { [weak self] in
            do {
                try self?.modelContext.save()
                self?.timer?.cancel()
                self?.timer = nil
            } catch {
                self?.timerManagerError = GenericError.dataSaving
            }
        }
    }

    deinit {
        stopGlobalTimer()
    }
}

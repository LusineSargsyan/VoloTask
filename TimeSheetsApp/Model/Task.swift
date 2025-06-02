//
//  Task.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import Foundation
import SwiftData

@Model
final class Task {
    var id: UUID
    var title: String
    var creationDate: Date = Date()
    var isInProgress: Bool = false
    var isCompleted: Bool = false
    var seconds: Int = 0
    var isFavorite: Bool
    var deadline: Date { creationDate.addingTimeInterval(100_000) }

    weak var project: Project?

    init(
        id: UUID = UUID(),
        creationDate: Date = Date(),
        isInProgress: Bool = false,
        isCompleted: Bool = false,
        seconds: Int = 0,
        title: String,
        isFavorite: Bool,
        project: Project?
    ) {
        self.id = id
        self.creationDate = creationDate
        self.isInProgress = isInProgress
        self.isCompleted = isCompleted
        self.seconds = seconds
        self.project = project
        self.isFavorite = isFavorite
        self.title = title
    }
}

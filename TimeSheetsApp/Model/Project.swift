//
//  Project.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import Foundation
import SwiftData

@Model
final class Project {
    var id: UUID = UUID()
    var name: String
    @Relationship(inverse: \Task.project)
    var tasks: [Task] = []

    init(name: String) {
        self.name = name
    }
}

//
//  DropDownItem.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import Foundation

enum DropDownItemType: String {
    case project = "Projects"
    case task = "Tasks"
}
struct DropDownItem: Identifiable {
    let type: DropDownItemType
    let options: [String]
    var selectedOptions: String?

    var title: String { type.rawValue }
    var id: String { type.rawValue }
}

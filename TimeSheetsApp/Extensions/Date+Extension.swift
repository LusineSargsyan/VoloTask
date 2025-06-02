//
//  Date+Extension.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import Foundation

extension Date {
    func toMMDDYYYY() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
}

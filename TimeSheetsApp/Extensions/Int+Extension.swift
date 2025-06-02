//
//  Int+Extension.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import Foundation

extension Int {
    func formatHHMMSS(forceHours: Bool = false) -> String {
        let seconds = self % 60
        let minutes = (self % 3600) / 60
        let hours = self / 3600
        let formatedMMSS = "\(minutes.twoDigitString) : \(seconds.twoDigitString)"
        let formatedHH = (hours > 0 || forceHours) ? hours.twoDigitString + " : " : ""

        return "\(formatedHH)\(formatedMMSS)"
    }

    var twoDigitString: String {
        self < 10 ? "0\(self)" : "\(self)"
    }
}

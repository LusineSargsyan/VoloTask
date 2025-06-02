//
//  TimerManagerWrapper.swift
//  TimeSheetsApp
//
//  Created by Lusine Sargsyan on 02.06.25.
//

import SwiftUI

final class TimerManagerWrapper: ObservableObject {
    @Published var manager: TimerManager? = nil

    func startGlobalTimer() {
        manager?.startGlobalTimer()
    }

    func stopGlobalTimer() {
        manager?.stopGlobalTimer()
    }
}

//
//  ViewModel.swift
//  TimerStopWatch
//
//  Created by Alex Hudson on 6/24/23.
//

import Foundation
import Observation

@Observable class ViewModel {
    private var minutes = 7
    private var seconds = 0
    private var timer: Timer = Timer()

    var clockType = ClockType.Timer

    private (set) var buttonText = "  Start   "
    private let startButtonText = "  Start   "
    private let stopButtonText = "  Stop  "

    func incrementTimerMinutes() {
        if minutes < 60 {
            minutes += 1
        } else {
            minutes = 0
        }
    }

    func decrementTimerMinutes() {
        if minutes > 0 {
            minutes -= 1
        } else {
            minutes = 60
        }
    }

    func incrementTimerSeconds() {
        if seconds < 59 {
            seconds += 1
        } else {
            seconds = 0
        }
    }

    func decrementTimerSeconds() {
        if seconds > 0 {
            seconds -= 1
        } else {
            seconds = 59
        }
    }

    func minutesString() -> String {
        let string = String(minutes)
        if string.count == 1 {
            return "0\(string)"
        } else {
            return string
        }
    }

    func secondsString() -> String {
        let string = String(seconds)
        if string.count == 1 {
            return "0\(string)"
        } else {
            return string
        }
    }

    func isInvalidState() -> Bool {
        clockType == .Timer && minutes == 0 && seconds == 0
    }

    func toggleClock() {

        if timer.isValid {
            stopClock()
        } else {
            startClock()
        }
    }

    func resetClockTime() {
        if clockType == .StopWatch {
            minutes = 0
        } else {
            minutes = 10
        }
        seconds = 0
        timer.invalidate()
        buttonText = startButtonText
    }

    func startClock() {
        switch clockType {
        case .Timer:
            startTimer()
        case .StopWatch:
            startStopWatch()
        }
        buttonText = stopButtonText
    }

    func stopClock() {
        switch clockType {
        case .Timer:
            stopTimer()
        case .StopWatch:
            stopStopWatch()
        }
        buttonText = startButtonText
    }

    func startStopWatch() {

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            self?.seconds += 1

            if self?.seconds == 60 {
                self?.minutes += 1
                self?.seconds = 0
            }

            if self?.minutes == 60 {
                timer.invalidate()
            }
        }

        timer.tolerance = 0.001
    }

    func stopStopWatch() {
        timer.invalidate()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.seconds -= 1
            if self?.seconds == 0 &&
                self?.minutes == 0 {
                self?.timer.invalidate()
            }

            if self?.seconds == 0 &&
                self?.minutes ?? 0 > 0 {
                self?.seconds -= 1
            }
        }

        timer.tolerance = 0.001
    }

    func stopTimer() {
        timer.invalidate()
        print(#function)
    }

}

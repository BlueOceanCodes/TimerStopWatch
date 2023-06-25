//
//  ViewModel.swift
//  TimerStopWatch
//
//  Created by Alex Hudson on 6/24/23.
//
import Observation

@Observable class ViewModel {
    private var minutes = 7
    private var seconds = 0
    var clockType = ClockType.Timer

    func incrementMinutes() {
        if minutes < 60 {
            minutes += 1
        } else {
            minutes = 0
        }
    }

    func decrementMinutes() {
        if minutes > 0 {
            minutes -= 1
        } else {
            minutes = 60
        }
    }

    func incrementSeconds() {
        if seconds < 59 {
            seconds += 1
        } else {
            seconds = 0
        }
    }

    func decrementSeconds() {
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
}

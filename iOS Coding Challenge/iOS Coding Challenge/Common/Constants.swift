//
//  Constants.swift
//  iOS Coding Challenge
//
//  Created by Max Ivanets on 20/02/2020.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

enum AppState {
    case idle
    case playing
    case recording
    case pausePlaying
    case pauseRecording
    case alarm
    
    var title: String {
        switch self {
        case .idle:
            return "Idle"
        case .playing:
            return "Playing"
        case .recording:
            return "Recording"
        case .pausePlaying, .pauseRecording:
            return "Paused"
        case .alarm:
            return "Alarm"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .idle, .pausePlaying, .pauseRecording, .alarm:
            return "Play"
        case .playing, .recording:
            return "Pause"
        }
    }
}

enum SleepTime: String, CaseIterable {
    case off = "off"
    case min_1 = "1 min"
    case min_5 = "5 min"
    case min_10 = "10 min"
    case min_15 = "15 min"
    case min_20 = "20 min"
    
    var interval: TimeInterval? {
        switch self {
        case .off:
            return nil
        case .min_1:
            return ((Calendar.current.date(byAdding: .minute, value: 1, to: Date())?.timeIntervalSince1970) ?? 0.0) - Date().timeIntervalSince1970
        case .min_5:
            return ((Calendar.current.date(byAdding: .minute, value: 1, to: Date())?.timeIntervalSince1970) ?? 0.0) - Date().timeIntervalSince1970
        case .min_10:
            return ((Calendar.current.date(byAdding: .minute, value: 1, to: Date())?.timeIntervalSince1970) ?? 0.0) - Date().timeIntervalSince1970
        case .min_15:
            return ((Calendar.current.date(byAdding: .minute, value: 1, to: Date())?.timeIntervalSince1970) ?? 0.0) - Date().timeIntervalSince1970
        case .min_20:
            return ((Calendar.current.date(byAdding: .minute, value: 1, to: Date())?.timeIntervalSince1970) ?? 0.0) - Date().timeIntervalSince1970
        }
    }
}

//
//  MockRecordingService.swift
//  iOS Coding ChallengeTests
//
//  Created by Max Ivanets on 2/24/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

class MockRecordingService {
    var isRecording = false
    var isPaused = false
    var alarm : TimeInterval?
    
    func isReady() -> Bool {
        return alarm != nil
    }
    
    func set(alarm: TimeInterval) {
        self.alarm = alarm
    }
    
    func record() {
        if isReady() {
            isRecording = true
            isPaused = false
        }
    }
    
    func pause() {
        if isRecording {
            isRecording = false
            isPaused = true
        }
    }
    
    func stop() {
        if isRecording {
            isRecording = false
            isPaused = false
        }
    }
}

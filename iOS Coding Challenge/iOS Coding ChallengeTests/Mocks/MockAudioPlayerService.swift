//
//  MockAudioPlayerService.swift
//  iOS Coding ChallengeTests
//
//  Created by Max Ivanets on 2/24/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation
@testable import iOS_Coding_Challenge

class MockAudioPlayerService {
    var interval: TimeInterval?
    var isPlaying = false
    var isPaused = false
    var volume = 1.0
    var volumeSettings = 1.0
    
    init() {
    }
    
    func isReady() -> Bool {
        return interval != nil
    }
    
    func set(sleeping: TimeInterval) {
        interval = sleeping
    }
    
    func sound(set on: Bool) {
        if on {
            volumeSettings = 1.0
        } else {
            volumeSettings = 0.0
        }
    }
    
    func start(playing: Sounds) {
        if isReady() {
            isPlaying = true
            isPaused = false
        } else {
            isPlaying = false
        }
        switch playing {
        case .nature:
            volume = volumeSettings
        case .alarm:
            volume = 1.0
        }
    }
    
    func pause() {
        if isPlaying {
            isPaused = true
            isPlaying = false
        }
    }
    
    func stop() {
        if isPlaying {
            isPlaying = false
            isPaused = false
        }
    }
}

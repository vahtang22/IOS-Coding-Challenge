//
//  PauseableTimer.swift
//  iOS Coding Challenge
//
//  Created by Max Ivanets on 23/02/2020.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

class PauseableTimer: NSObject {
    var timer: Timer!
    private(set) var isPause: Bool = false
    private var timeLeft: TimeInterval?
    
    init(timer aTimer: Timer) {
        self.timer = aTimer
    }
    
    func pause() {
        if !isPause {
            timeLeft = self.timer.fireDate.timeIntervalSinceNow
            self.timer.fireDate = Date(timeIntervalSinceNow: 3600*10000)
            isPause = true
        }
    }
    
    func resume() {
        if isPause {
            self.timer.fireDate = Date().addingTimeInterval(timeLeft!)
            isPause = false
        }
    }
    
    func invalidate() {
        self.timer.invalidate()
    }
}

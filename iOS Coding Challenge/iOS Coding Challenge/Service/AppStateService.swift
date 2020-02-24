//
//  AppStateService.swift
//  iOS Coding Challenge
//
//  Created by Max Ivanets on 22/02/2020.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

protocol AppStateServiceDelegate: class {
    func applicationCanChangeState() -> Bool
    func applicationDidChange(state: AppState)
}

class AppStateService {
    weak var delegate: AppStateServiceDelegate?
    var currentState: AppState = .idle
    
    func toggleState() {
        if let valid = delegate?.applicationCanChangeState() {
            if valid {
                switch currentState {
                case .idle:
                    currentState = .playing
                case .playing:
                    currentState = .pausePlaying
                case .recording:
                    currentState = .pauseRecording
                case .pausePlaying:
                    currentState = .playing
                case .pauseRecording:
                    currentState = .recording
                default:
                    break
                }
            }
            delegate?.applicationDidChange(state: currentState)
        }
    }
    
    func set(state: AppState) {
        if let valid = delegate?.applicationCanChangeState() {
            if valid {
                if currentState != state {
                    currentState = state
                    delegate?.applicationDidChange(state: currentState)
                }
            }
        }
    }
}

//
//  MainInteractor.swift
//  iOS Coding Challenge
//
//  Created by Max Ivanets on 20/02/2020.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

protocol MainInteractorProtocol: class {
    func set(sleeping: TimeInterval)
    func set(alarm: Date)
    func toggleState()
    func stopAlarm()
    func sound(set on: Bool)
}

class MainInteractor {
    weak var presenter: MainPresenterProtocol!
    
    private let playerService = AudioPlayerService()
    private let appStateService = AppStateService()
    private let recordingService = RecordingService()
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        self.playerService.delegate = self
        self.appStateService.delegate = self
        self.recordingService.delegate = self
    }
}

extension MainInteractor: MainInteractorProtocol {
    func sound(set on: Bool) {
        playerService.sound(set: on)
    }
    
    func stopAlarm() {
        appStateService.set(state: .idle)
    }
    
    func set(sleeping: TimeInterval) {
        playerService.set(sleeping: sleeping)
    }
    
    func set(alarm: Date) {
        recordingService.set(alarm: alarm)
    }
    
    func toggleState() {
        appStateService.toggleState()
    }
}

extension MainInteractor: AudioPlayerServiceDelegate {
    func soundStoped() {
        appStateService.set(state: .recording)
    }
    
    func soundPaused() {
        appStateService.set(state: .pausePlaying)
    }
}

extension MainInteractor: AppStateServiceDelegate {
    func applicationCanChangeState() -> Bool {
        return playerService.isReady() && recordingService.isReady()
    }
    
    func applicationDidChange(state: AppState) {
        switch state {
        case .playing:
            playerService.start(playing: .nature)
        case .recording:
            recordingService.record()
        case .alarm:
            playerService.start(playing: .alarm)
            NotificationService.shared.sendNotification()
        case .pausePlaying:
            playerService.pause()
        case .pauseRecording:
            recordingService.pause()
        case .idle:
            playerService.invalidate()
            recordingService.stop()
        }
        presenter.apply(state: state)
    }
}

extension MainInteractor: RecordingServiceDelegate {
    func recordingDidFinish(with success: Bool) {
        appStateService.set(state: .alarm)
    }
    
    func recordingPaused() {
        appStateService.set(state: .pauseRecording)
    }
}

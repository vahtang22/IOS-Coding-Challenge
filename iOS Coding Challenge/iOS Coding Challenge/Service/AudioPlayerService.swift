//
//  SleepingService.swift
//  iOS Coding Challenge
//
//  Created by Max Ivanets on 20/02/2020.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation
import AVFoundation

enum Sounds {
    case nature
    case alarm
    
    var path: URL? {
        switch self {
        case .nature:
            return Bundle.main.url(forResource: "nature", withExtension: "mp4")
        case .alarm:
            return Bundle.main.url(forResource: "alarm", withExtension: "mp4")
        }
    }
}

protocol AudioPlayerServiceDelegate: class {
    func soundStoped()
    func soundPaused()
}

class AudioPlayerService: NSObject {
    weak var delegate: AudioPlayerServiceDelegate?
    
    private var duration: TimeInterval?
    private var player: AVAudioPlayer?
    private var timer: PauseableTimer?
    private var isPaused = false
    private var soundVolume: Float = 1.0
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption(notification:)), name: AVAudioSession.interruptionNotification, object: AVAudioSession.sharedInstance())
    }
    
    @objc func handleInterruption(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue)
        else { return }
        
        switch type {
        case .began:
            pause()
        case .ended:
            break
        default: ()
        }
    }
    
    func preparePlayer(for sound: Sounds) {
        if let path = sound.path {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playAndRecord)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                player = try AVAudioPlayer(contentsOf: path, fileTypeHint: AVFileType.mp4.rawValue)
                player?.numberOfLoops = -1
                player?.prepareToPlay()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func isReady() -> Bool {
        return duration != nil
    }
    
    func set(sleeping: TimeInterval) {
        duration = sleeping
    }
    
    func sound(set on: Bool) {
        guard let player = player else { return }
        if on {
            soundVolume = 1.0
            player.volume = soundVolume
        } else {
            soundVolume = 0.0
            player.volume = soundVolume
        }
    }
    
    func start(playing: Sounds) {
        preparePlayer(for: playing)
        guard let player = player else { return }
        if isPaused {
            isPaused = false
            timer?.resume()
        } else {
            if playing != .alarm {
                guard let duration = duration else { return }
                timer = PauseableTimer.init(timer: Timer.scheduledTimer(withTimeInterval: duration, repeats: false, block: { [unowned self] _ in
                    self.stop()
                }))
                isPaused = false
            }
        }
        switch playing {
        case .nature:
            player.volume = soundVolume
        case .alarm:
            player.volume = 1.0
        }
        player.play()
    }
    
    func pause() {
        guard let player = player else { return }
        if player.isPlaying {
            isPaused = true
            player.pause()
            timer?.pause()
            delegate?.soundPaused()
        }
    }
    
    func stop() {
        guard let player = player else { return }
        if player.isPlaying {
            isPaused = false
            player.currentTime = 0
            player.stop()
            timer?.timer.invalidate()
            delegate?.soundStoped()
        }
    }
    
    func invalidate() {
        guard let player = player else { return }
        if player.isPlaying {
            isPaused = false
            player.currentTime = 0
            player.stop()
            timer?.timer.invalidate()
        }
    }
}

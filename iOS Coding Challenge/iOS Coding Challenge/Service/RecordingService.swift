//
//  RecordingService.swift
//  iOS Coding Challenge
//
//  Created by Max Ivanets on 23/02/2020.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation
import AVFoundation

protocol RecordingServiceDelegate: class {
    func recordingDidFinish(with success: Bool)
    func recordingPaused()
}

class RecordingService: NSObject {
    private var documentsPath: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    private var recordPath: URL {
        return documentsPath.appendingPathComponent("record.mp4")
    }
    private var recorder: AVAudioRecorder?
    private var alarm: Date?
    private var timer: PauseableTimer?
    private var isPaused = false
    private var isInterrupted = false
    
    weak var delegate: RecordingServiceDelegate?
    
    override init() {
        super.init()
        checkPermision()
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVNumberOfChannelsKey: 1,
            AVSampleRateKey: 12000,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            recorder = try AVAudioRecorder(url: recordPath, settings: settings)
            recorder?.delegate = self
        } catch {
            print(error.localizedDescription)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption(notification:)), name: AVAudioSession.interruptionNotification, object: AVAudioSession.sharedInstance())
    }
    
    private func checkPermision() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            break
        case .denied:
            break
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { allowed in
                if allowed {
                    print("Allowed")
                }
            }
            break
        default:
            break
        }
    }
    
    private func removeRecordIfNeeded() {
        if FileManager.default.fileExists(atPath: recordPath.absoluteString) {
            do {
                try FileManager.default.removeItem(at: recordPath)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func handleInterruption(notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue)
        else { return }
        
        switch type {
        case .began:
            isInterrupted = true
            pause()
        case .ended:
            break
        default: ()
        }
    }
    
    func isReady() -> Bool {
        return alarm != nil
    }
    
    func set(alarm: Date) {
        self.alarm = alarm
    }
    
    func record() {
        guard let alarm = alarm else { return }
        guard let recorder = recorder else { return }
        isInterrupted = false
        if isPaused {
            isPaused = false
            timer?.resume()
        } else {
            removeRecordIfNeeded()
            recorder.prepareToRecord()
            let interval = alarm.timeIntervalSince1970 - Date().timeIntervalSince1970
            timer = PauseableTimer.init(timer: Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: { [unowned self] _ in
                self.stop()
            }))
            isPaused = false
        }
        recorder.record()
    }
    
    func pause() {
        guard let recorder = recorder else { return }
        if isInterrupted {
            isPaused = true
            timer?.pause()
            recorder.pause()
            delegate?.recordingPaused()
        } else {
            if recorder.isRecording {
                isPaused = true
                timer?.pause()
                recorder.pause()
                delegate?.recordingPaused()
            }
        }
    }
    
    func stop() {
        guard let recorder = recorder else { return }
        if recorder.isRecording {
            isPaused = false
            recorder.stop()
            timer?.timer.invalidate()
        }
    }
}

extension RecordingService: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        delegate?.recordingDidFinish(with: flag)
    }
}

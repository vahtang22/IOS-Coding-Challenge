//
//  iOS_Coding_ChallengeTests.swift
//  iOS Coding ChallengeTests
//
//  Created by Max Ivanets on 2/24/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import XCTest
@testable import iOS_Coding_Challenge

class iOS_Coding_ChallengeTests: XCTestCase {
    
    var playerService: MockAudioPlayerService!
    var recordingService: MockRecordingService!

    override func setUp() {
        playerService = MockAudioPlayerService()
        recordingService = MockRecordingService()
    }

    override func tearDown() {
        playerService = nil
        recordingService = nil
    }
    
    // MARK: - Audio Service TESTS
    
    func testPlayerServiceIsReady_1() {
        XCTAssertFalse(playerService.isReady())
    }
    
    func testPlayerServiceIsReady_2() {
        playerService.set(sleeping: 1.0)
        XCTAssertTrue(playerService.isReady())
    }
    
    func testPlayerService_1() {
        playerService.start(playing: .nature)
        XCTAssertFalse(playerService.isPlaying)
    }
    
    func testPlayerService_2() {
        playerService.set(sleeping: 1.0)
        playerService.start(playing: .nature)
        XCTAssertTrue(playerService.isPlaying)
    }
    
    func testPlayerService_3() {
        playerService.set(sleeping: 1.0)
        playerService.start(playing: .nature)
        playerService.pause()
        XCTAssertTrue(playerService.isPaused)
        XCTAssertFalse(playerService.isPlaying)
    }
    
    func testPlayerService_4() {
        playerService.set(sleeping: 1.0)
        playerService.start(playing: .nature)
        playerService.stop()
        XCTAssertFalse(playerService.isPaused)
        XCTAssertFalse(playerService.isPlaying)
    }
    
    func testPlayerService_5() {
        playerService.set(sleeping: 1.0)
        playerService.start(playing: .nature)
        playerService.pause()
        playerService.start(playing: .nature)
        XCTAssertTrue(playerService.isPlaying)
        XCTAssertFalse(playerService.isPaused)
    }
    
    func testPlayerService_6() {
        playerService.sound(set: false)
        XCTAssertTrue(playerService.volumeSettings == 0.0)
    }
    
    func testPlayerService_7() {
        playerService.sound(set: true)
        XCTAssertTrue(playerService.volumeSettings == 1.0)
    }
    
    func testPlayerService_8() {
        playerService.sound(set: false)
        playerService.start(playing: .nature)
        XCTAssertTrue(playerService.volume == 0.0)
    }
    
    func testPlayerService_9() {
        playerService.sound(set: true)
        playerService.start(playing: .nature)
        XCTAssertTrue(playerService.volume == 1.0)
    }
    
    func testPlayerService_10() {
        playerService.sound(set: false)
        playerService.start(playing: .alarm)
        XCTAssertTrue(playerService.volume == 1.0)
    }
    
    func testPlayerService_11() {
        playerService.pause()
        XCTAssertFalse(playerService.isPaused)
    }
    
    // MARK: - Recording Service TESTS
    
    func testRecordingServiceIsReady_1() {
        XCTAssertFalse(recordingService.isReady())
    }
    
    func testRecordingServiceIsReady_2() {
        recordingService.set(alarm: 1.0)
        XCTAssertTrue(recordingService.isReady())
    }
    
    func testRecordingService_1() {
        recordingService.set(alarm: 1.0)
        recordingService.record()
        XCTAssertTrue(recordingService.isRecording)
    }
    
    func testRecordingService_2() {
        recordingService.record()
        XCTAssertFalse(recordingService.isRecording)
    }
    
    func testRecordingService_3() {
        recordingService.set(alarm: 1.0)
        recordingService.record()
        recordingService.pause()
        XCTAssertTrue(recordingService.isPaused)
        XCTAssertFalse(recordingService.isRecording)
    }
    
    func testRecordingService_4() {
        recordingService.pause()
        XCTAssertFalse(recordingService.isPaused)
    }
    
    func testRecordingService_5() {
        recordingService.set(alarm: 1.0)
        recordingService.record()
        recordingService.stop()
        XCTAssertFalse(recordingService.isRecording)
        XCTAssertFalse(recordingService.isPaused)
    }
}

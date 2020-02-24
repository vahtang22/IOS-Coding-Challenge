//
//  MainPresenter.swift
//  iOS Coding Challenge
//
//  Created by Max Ivanets on 20/02/2020.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

protocol MainPresenterProtocol: class {
    func configureView()
    func toggleState()
    func apply(state: AppState)
    func set(sleep: SleepTime)
    func set(alarm: Date)
    func selectSleeping(with options: [SleepTime])
    func stopAlarm()
    func sound(set on: Bool)
}

class MainPresenter {
    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
}

extension MainPresenter: MainPresenterProtocol {
    func sound(set on: Bool) {
        interactor.sound(set: on)
    }
    
    func stopAlarm() {
        interactor.stopAlarm()
    }
    
    func apply(state: AppState) {
        view.apply(state: state)
    }
    
    func set(sleep: SleepTime) {
        if let interval = sleep.interval {
            interactor.set(sleeping: interval)
            view.apply(sleep: sleep)
        }
    }
    
    func set(alarm: Date) {
        interactor.set(alarm: alarm)
        view.apply(alarm: alarm.formatted())
    }
    
    func configureView() {
        view.configureView()
        view.apply(state: .idle)
        view.apply(sleep: .off)
        view.apply(alarm: Date().formatted())
    }
    
    func toggleState() {
        interactor.toggleState()
    }
    
    func selectSleeping(with options: [SleepTime]) {
        view.select(sleeping: options)
    }
}

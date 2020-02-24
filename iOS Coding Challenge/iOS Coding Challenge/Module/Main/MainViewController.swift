//
//  MainViewController.swift
//  iOS Coding Challenge
//
//  Created by Max Ivanets on 20/02/2020.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let content = MainView()
    let configurator = MainConfigurator()
    
    var presenter: MainPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    @objc func selectSleeping() {
        presenter.selectSleeping(with: SleepTime.allCases)
    }
    
    @objc func selectAlarm(sender: UIDatePicker) {
        presenter.set(alarm: sender.date)
        view.endEditing(true)
    }
    
    @objc func play() {
        presenter.toggleState()
    }
    
    @objc func switchAudio(sender: UISwitch) {
        presenter.sound(set: sender.isOn)
    }
}

extension MainViewController: MainViewProtocol {
    func configureView() {
        view.addFullSizeSubView(view: content)
        content.sleepTimerButton.addTarget(self, action: #selector(selectSleeping), for: .touchUpInside)
        content.actionButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        content.audioSwitch.addTarget(self, action: #selector(switchAudio(sender:)), for: .valueChanged)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(selectAlarm(sender:)), for: .valueChanged)
        content.alarmTimerButton.inputView = datePicker
    }
    
    func select(sleeping: [SleepTime]) {
        let actionSheet = UIAlertController.init(title: "Sleeping", message: "Select option", preferredStyle: .actionSheet)
        sleeping.forEach { [unowned self] option in
            actionSheet.addAction(UIAlertAction.init(title: option.rawValue, style: .default, handler: { _ in
                self.presenter.set(sleep: option)
            }))
        }
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func apply(state: AppState) {
        content.stateLabel.text = state.title
        content.actionButton.setTitle(state.buttonTitle, for: .normal)
        if state == .alarm {
            let alert = UIAlertController.init(title: "Wake up", message: "You sleep record is in Documents", preferredStyle: .alert)
            let action = UIAlertAction.init(title: "Stop", style: .cancel) { [unowned self] _ in
                self.presenter.stopAlarm()
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func apply(sleep: SleepTime) {
        content.sleepTimerButton.setTitle(sleep.rawValue, for: .normal)
    }
    
    func apply(alarm: String) {
        content.alarmTimerButton.text = alarm
    }
}

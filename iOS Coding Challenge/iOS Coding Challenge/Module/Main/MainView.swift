//
//  MainView.swift
//  iOS Coding Challenge
//
//  Created by Max Ivanets on 20/02/2020.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit
import SnapKit

protocol MainViewProtocol: class {
    func apply(state: AppState)
    func apply(sleep: SleepTime)
    func apply(alarm: String)
    func select(sleeping: [SleepTime])
    func configureView()
}

class MainView: UIView {
    let stateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return view
    }()
    let sleepTimerLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Sleep timer"
        view.textColor = .gray
        return view
    }()
    let alarmTimerLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Alarm"
        view.textColor = .gray
        return view
    }()
    
    let sleepTimerButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.blue, for: .normal)
        view.backgroundColor = .white
        return view
    }()
    let alarmTimerButton: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.textAlignment = .right
        return view
    }()
    let actionButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .blue
        view.layer.cornerRadius = 8
        return view
    }()
    let audioSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setOn(true, animated: false)
        return view
    }()
    let audioLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Play audio"
        view.textColor = .gray
        return view
    }()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        addSubview(stateLabel)
        addSubview(actionButton)
        addSubview(alarmTimerLabel)
        addSubview(sleepTimerLabel)
        addSubview(alarmTimerButton)
        addSubview(sleepTimerButton)
        addSubview(audioLabel)
        addSubview(audioSwitch)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        removeConstraints(constraints)
        stateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(60)
            make.centerX.equalTo(self)
        }
        actionButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-30)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self).offset(-16)
            make.height.equalTo(40)
        }
        alarmTimerLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(16)
            make.bottom.equalTo(actionButton.snp.top).offset(-30)
        }
        sleepTimerLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(16)
            make.bottom.equalTo(alarmTimerLabel.snp.top).offset(-16)
        }
        audioLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(16)
            make.bottom.equalTo(sleepTimerLabel.snp.top).offset(-16)
        }
        audioSwitch.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-16)
            make.centerY.equalTo(audioLabel)
        }
        alarmTimerButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-16)
            make.centerY.equalTo(alarmTimerLabel)
        }
        sleepTimerButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-16)
            make.centerY.equalTo(sleepTimerLabel)
        }
        super.updateConstraints()
    }
}

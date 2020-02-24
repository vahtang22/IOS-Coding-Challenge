//
//  NotificationService.swift
//  iOS Coding Challenge
//
//  Created by Max Ivanets on 2/24/20.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    
    private init() {
    }
    
    func register() {
        let notificationCenter = UNUserNotificationCenter.current()
        let notififcationOptions: UNAuthorizationOptions = [.alert]
        notificationCenter.requestAuthorization(options: notififcationOptions) { allow, error in
            if allow {
                print("Allowed")
            }
        }
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Wake up"
        content.body = "Your record in documents"
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1.0, repeats: false)
        let request = UNNotificationRequest.init(identifier: "alert", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

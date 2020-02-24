//
//  Date+Format.swift
//  iOS Coding Challenge
//
//  Created by Max Ivanets on 20/02/2020.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import Foundation

extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
}

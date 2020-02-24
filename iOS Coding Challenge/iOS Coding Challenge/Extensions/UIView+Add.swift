//
//  UIView+Add.swift
//  iOS Coding Challenge
//
//  Created by Max Ivanets on 20/02/2020.
//  Copyright © 2020 Max Ivanets. All rights reserved.
//

import UIKit

public extension UIView {
    func addSubviewStretched(subview: UIView, insets: UIEdgeInsets = UIEdgeInsets()) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)

        let constraintLeading = NSLayoutConstraint(item: subview,
                                                   attribute: .left,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .left,
                                                   multiplier: 1,
                                                   constant: insets.left)
        addConstraint(constraintLeading)

        let constraintTrailing = NSLayoutConstraint(item: self,
                                                    attribute: .right,
                                                    relatedBy: .equal,
                                                    toItem: subview,
                                                    attribute: .right,
                                                    multiplier: 1,
                                                    constant: insets.right)
        addConstraint(constraintTrailing)

        let constraintTop = NSLayoutConstraint(item: subview,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: insets.top)
        addConstraint(constraintTop)

        let constraintBottom = NSLayoutConstraint(item: self,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: subview,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: insets.bottom)
        addConstraint(constraintBottom)
    }
    
    func addFullSizeSubView(view: UIView) {
        addSubviewStretched(subview: view, insets: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
    }
}

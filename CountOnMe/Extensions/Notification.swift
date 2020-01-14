//
//  Notification.swift
//  CountOnMe
//
//  Created by Elie Arquier on 13/12/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

extension Notification {
    /// lists of alert cases
    enum Alert {
        case dotIsAlone, canNotDivideByZero, canNotAddDot, canNotAddOperator,
        canNotStartNewCalcul, expressionHaveNotEnoughElement, syntaxError, unknownOperator
    }

    static func viewNotification(textView: String) {
        NotificationCenter.default.post(name: .nameView, object: nil, userInfo: ["TextView": textView])
    }

    static func alertNotification(userInfo: Alert) {
        NotificationCenter.default.post(name: .nameAlert, object: nil, userInfo: ["alert": userInfo])
    }
}

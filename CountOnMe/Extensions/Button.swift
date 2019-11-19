//
//  Button.swift
//  CountOnMe
//
//  Created by Elie Arquier on 19/11/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

extension UIButton {
    func animated() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (_) in
            self.transform = .identity
        }
    }
}

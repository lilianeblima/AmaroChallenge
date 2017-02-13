//
//  Extensions.swift
//  AmaroChallenge
//
//  Created by Liliane Bezerra Lima on 13/02/17.
//  Copyright © 2017 Liliane Bezerra Lima. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    func toPrice() -> String {
        return String(format: "R$ %.2f", self).replacingOccurrences(of: ".", with: ",")
    }
}

extension UIView {
    func roundRadius() {
        self.layer.cornerRadius = self.frame.height / 2.0
    }
}

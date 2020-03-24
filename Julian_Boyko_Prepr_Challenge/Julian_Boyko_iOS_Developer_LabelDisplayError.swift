//
//  Julian_Boyko_iOS_Developer_LabelDisplayError.swift
//  Julian_Boyko_Prepr_Challenge
//
//  Created by Julian Boyko on 2020-03-22.
//  Copyright © 2020 Supreme Apps. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func displayError(_ error: String) {
        self.text = error
        self.textColor = .red
        self.alpha = 1
    }
}

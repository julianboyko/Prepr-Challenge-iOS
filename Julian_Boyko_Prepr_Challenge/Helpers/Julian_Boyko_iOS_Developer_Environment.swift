//
//  Julian_Boyko_iOS_Developer_Environment.swift
//  Julian_Boyko_Prepr_Challenge
//
//  Created by Julian Boyko on 2020-03-20.
//  Copyright © 2020 Supreme Apps. All rights reserved.
//

import Foundation

struct Environment {
    
    struct Storyboard {
        static let homeNavigationController = "HomeNavigationController"
        static let homeViewController = "HomeViewController"
        static let homeViewControllerTableViewCell = "addressCell"
        static let mainNavigationController = "MainNavigationController"
        static let mainViewController = "MainViewController"
        
        struct Segues {
            static let addressDetailSegue = "toAddressDetail"
            static let addressAddSegue = "toAddressAdd"
        }
    }
    
}

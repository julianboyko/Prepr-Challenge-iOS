//
//  Julian_Boyko_iOS_Developer_AddressDetailVC.swift
//  Julian_Boyko_Prepr_Challenge
//
//  Created by Julian Boyko on 2020-03-21.
//  Copyright © 2020 Supreme Apps. All rights reserved.
//

import UIKit

class Julian_Boyko_iOS_Developer_AddressDetailVC: UIViewController {
    
    // MARK: Attributes

    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var passedInAddress: Address?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttributes()
    }
    
    func setUpAttributes() {
        Utilities.styleFilledButton(backButton)
        if passedInAddress != nil {
            addressTitleLabel.text = passedInAddress!.name + "'s Address"
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

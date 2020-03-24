//
//  Julian_Boyko_iOS_Developer_AddAddressVC.swift
//  Julian_Boyko_Prepr_Challenge
//
//  Created by Julian Boyko on 2020-03-20.
//  Copyright © 2020 Supreme Apps. All rights reserved.
//

import UIKit

protocol AddressAddDelegate: AnyObject {
    func addAddressDidCancel(_ controller: UIViewController)
    func addAddress(_ controller: UIViewController, didSave item: Address)
}

class Julian_Boyko_iOS_Developer_AddAddressVC: UIViewController {
    
    weak var delegate: AddressAddDelegate?

    // MARK: Attributes
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var provinceTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttributes()
    }
    
    func setUpAttributes() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(streetAddressTextField)
        Utilities.styleTextField(cityTextField)
        Utilities.styleTextField(provinceTextField)
        Utilities.styleTextField(postalCodeTextField)
        
        Utilities.styleFilledButton(addButton)
        Utilities.styleHollowButton(backButton)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let errorMessage = validateFields()
        
        if errorMessage != nil {
            errorLabel.displayError(errorMessage!)
            return
        }
        
        let newAddress = Address(name: nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                                 streetAddress: streetAddressTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                                 city: cityTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                                 province: provinceTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                                 postalCode: postalCodeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        
        delegate?.addAddress(self, didSave: newAddress)
    }
    
    func validateFields() -> String? {
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            streetAddressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            provinceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            cityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            postalCodeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        delegate?.addAddressDidCancel(self)
    }
    
}

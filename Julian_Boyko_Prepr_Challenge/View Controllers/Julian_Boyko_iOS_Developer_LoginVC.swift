//
//  Julian_Boyko_iOS_Developer_LoginVC.swift
//  Julian_Boyko_Prepr_Challenge
//
//  Created by Julian Boyko on 2020-03-20.
//  Copyright © 2020 Supreme Apps. All rights reserved.
//

import UIKit
import FirebaseAuth

class Julian_Boyko_iOS_Developer_LoginVC: UIViewController {

    // MARK: Attributes
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAttributes()
    }
    
    func setUpAttributes() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleHollowButton(backButton)
        Utilities.styleFilledButton(loginButton)
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        /*
         This function validates the text fields
         & then signs in the user
         */
        
        let errorMessage = validateFields()
        
        if errorMessage != nil {
            displayError(error: errorMessage!)
            return
        }
        
        Auth.auth().signIn(withEmail: emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                           password: passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { (results, error) in
                            
                            if error != nil {
                                self.displayError(error: error!.localizedDescription)
                            } else {
                                self.goToHomeScreen()
                            }
        }
    }
    
    func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    func displayError(error: String) {
        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    func goToHomeScreen() {
        let homeNavigationController = storyboard?.instantiateViewController(identifier: Environment.Storyboard.homeNavigationController) as? UINavigationController
        
        view.window?.rootViewController = homeNavigationController
        view.window?.makeKeyAndVisible()
    }
}

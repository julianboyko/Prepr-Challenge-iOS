//
//  Julian_Boyko_iOS_Developer_SignUpVC.swift
//  Julian_Boyko_Prepr_Challenge
//
//  Created by Julian Boyko on 2020-03-20.
//  Copyright © 2020 Supreme Apps. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class Julian_Boyko_iOS_Developer_SignUpVC: UIViewController {

    // MARK: Attributes
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAttributes()
    }
    
    func setUpAttributes() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleHollowButton(backButton)
        Utilities.styleFilledButton(signUpButton)
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        /*
         This function will validate the fields
         Create the user
         and then transition to the home screen
         */
        
        let errorMessage = validateFields()
        
        if errorMessage != nil {
            displayError(error: errorMessage!)
            return
        }
        
        Auth.auth().createUser(withEmail: emailTextField.text!,
                               password: passwordTextField.text!) { (result, error) in
                                
                                if error != nil {
                                    self.displayError(error: "Firebase error: " + error!.localizedDescription)
                                } else {
                                    let firebaseDB = Firestore.firestore()
                                    // Adds a user to the firestore database by their unique UID
                                    firebaseDB.collection("users").document(result!.user.uid).setData(
                                    [
                                            "first_name": self.firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                                            "last_name": self.lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                                            "uid": result!.user.uid
                                    ]) { (error) in
                                        if error != nil {
                                            self.displayError(error: "Firebase failed storing user first name and last name")
                                        }
                                    }
                                    
                                    self.goToHomeScreen()
                                }
        }
    }
    
    func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        if Utilities.isPasswordValid(passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false {
            return "Please enter a secure password (8 characters with a special character & number)"
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

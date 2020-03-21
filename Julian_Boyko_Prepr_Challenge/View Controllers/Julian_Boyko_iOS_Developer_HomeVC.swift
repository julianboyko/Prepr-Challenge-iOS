//
//  Julian_Boyko_iOS_Developer_HomeVC.swift
//  Julian_Boyko_Prepr_Challenge
//
//  Created by Julian Boyko on 2020-03-20.
//  Copyright © 2020 Supreme Apps. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import CodableFirebase

class Julian_Boyko_iOS_Developer_HomeVC: UIViewController, UITableViewDataSource, AddressAddDelegate {
    
    // MARK: Attributes
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var addresses = [Address]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAttributes()
        getAddressesFromFirestore()
    }
    
    func setUpAttributes() {
        Utilities.styleFilledButton(addButton)
        Utilities.styleHollowButton(logoutButton)
        
        tableView.dataSource = self
    }
    
    func getAddressesFromFirestore() {
        let firestoreDB = Firestore.firestore()
        let userDocument = firestoreDB.collection("users").document(Auth.auth().currentUser!.uid)
        
        userDocument.getDocument { (document, error) in
            if let document = document, document.exists {
                if let addresses = document.get("addresses") as? NSArray {
                    for address in addresses {
                        let retrievedAddress = try! FirestoreDecoder().decode(Address.self, from: address as! [String : Any])
                        self.addresses.append(retrievedAddress)
                    }
                    self.tableView.reloadData()
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            goToMainScreen()
        } catch let signOutError as NSError {
            print("Error signing out: " + signOutError.localizedDescription)
        }
    }
    
    func goToMainScreen() {
        let mainNavigationwController = storyboard?.instantiateViewController(identifier: Environment.Storyboard.mainNavigationController) as? UINavigationController
        
        view.window?.rootViewController = mainNavigationwController
        view.window?.makeKeyAndVisible()
    }
    
    func addAddressDidCancel(_ controller: UIViewController) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addAddress(_ controller: UIViewController, didSave item: Address) {
        self.navigationController?.popViewController(animated: true)
        addresses.append(item)
        tableView.reloadData()
        
        let firebaseDB = Firestore.firestore()
        let docData = try! FirestoreEncoder().encode(item)
        
        let userDocument = firebaseDB.collection("users").document(Auth.auth().currentUser!.uid)
        userDocument.updateData([
            "addresses": FieldValue.arrayUnion([
                docData
            ])
        ])
    }
    
    // MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Environment.Storyboard.homeViewControllerTableViewCell)!
        
        let address = addresses[indexPath.row]
        
        cell.textLabel?.text = address.name
        cell.selectionStyle = .none
        
        return cell
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Environment.Storyboard.Segues.addressAddSegue {
            let addAddressViewController = segue.destination as! Julian_Boyko_iOS_Developer_AddAddressVC
            addAddressViewController.delegate = self
        }
        
        if segue.identifier == Environment.Storyboard.Segues.addressDetailSegue {
            let addressDetailViewController = segue.destination as! Julian_Boyko_iOS_Developer_AddressDetailVC
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            let selectedAddress = addresses[indexPath!.row]
            
            addressDetailViewController.passedInAddress = selectedAddress
        }
    }
}

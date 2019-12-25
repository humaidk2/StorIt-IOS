//
//  SignUpViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 12/24/19.
//  Copyright © 2019 Cyber-Monkeys. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mDatePicker: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    private var datePicker : UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mTitle.text = "Join the \nCommunity"
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(SignUpViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        //remove datepicker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        mDatePicker.inputView = datePicker
        
        
    }
    
    
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker : UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        mDatePicker.text = dateFormatter.string(from: datePicker.date)
        
        //removes date picker once user chooses a date
        view.endEditing(true)
        
    }
    
    @IBAction func signin(_ sender: Any) {
        let email = txtEmail.text!
        let password = txtPassword.text!
        let confirmPassword = txtConfirmPassword.text!
        
        //check if password is same
        if password == confirmPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
              
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    return
                }
                
                //if success, logout and go to login
                let firebaseAuth = Auth.auth()
                do {
                  try firebaseAuth.signOut()
                    print("user logged out")
                    self.dismiss(animated: true, completion: nil)
                } catch let signOutError as NSError {
                  print ("Error signing out: %@", signOutError)
                }
               
            }
        }
        
    }

}

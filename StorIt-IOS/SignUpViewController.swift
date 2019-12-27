//
//  SignUpViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 12/24/19.
//  Copyright © 2019 Cyber-Monkeys. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mDatePicker: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
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
        
        //add icon to txtEmail
        let emailImage = UIImage(systemName: "envelope.fill")
        addLeftImageTo(txtField: txtEmail, andImage: emailImage!)
        //add icon to txtPassword
        let passImage = UIImage(systemName: "lock.fill")
        addLeftImageTo(txtField: txtPassword, andImage: passImage!)
        addLeftImageTo(txtField: txtConfirmPassword, andImage: passImage!)
        //add icon to txtUsername, firstName, and lastName
        let personImage = UIImage(systemName: "person.fill")
        addLeftImageTo(txtField: txtUsername, andImage: personImage!)
        addLeftImageTo(txtField: txtFirstName, andImage: personImage!)
        addLeftImageTo(txtField: txtLastName, andImage: personImage!)
        //add icon to mDatePicker
        let bDayImage = UIImage(systemName: "calendar")
        addLeftImageTo(txtField: mDatePicker, andImage: bDayImage!)
        
        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
    
    //put icon on left side of textfield
    func addLeftImageTo(txtField : UITextField, andImage img: UIImage){
        
        //create outerview to have padding for leftImageView
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: img.size.width+10, height: img.size.height))
        let leftImageView = UIImageView(frame: CGRect(x: 10, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        outerView.addSubview(leftImageView)
        txtField.leftView = outerView
        txtField.leftView?.tintColor = UIColor.systemGray4
        txtField.leftViewMode = .always
    }
    
    deinit{
        //stop listening for keyboard hide/show events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    //move textfield when keyboard opens
    @objc func keyboardWillChange(notification: Notification){
        print("Keyboard will show")
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        //move view if textfield is pressed
        if txtConfirmPassword.isEditing || txtPassword.isEditing{
            if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
                
                view.frame.origin.y = -keyboardRect.height
            }else {
                view.frame.origin.y = 0
            }
        }
        
    }

}

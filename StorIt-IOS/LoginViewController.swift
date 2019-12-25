//
//  LoginViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 12/24/19.
//  Copyright © 2019 Cyber-Monkeys. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, UITextFieldDelegate{

    //variables
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       Auth.auth().addStateDidChangeListener
        { (auth, user) in
            
            if user != nil {
              self.goToMenu()
            }
            
        }
          
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
          // Do any additional setup after loading the view.
        
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self
    }
    
    //hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //hide keyboard when user presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
        return(true)
    }
    
    //login
    @IBAction func login(_ sender: Any) {
        
        let email = txtEmail.text!
        let password = txtPassword.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
           print(authResult)
            if let firebaseError = error {
                print(firebaseError.localizedDescription)
                return
            }
            print("login success")
            //self?.goToMenu()
        }
        
    }
    
    func goToMenu(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let clientVC:TabBarViewController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarViewController
        
        //go to new screen in fullscreen
        clientVC.modalPresentationStyle = .fullScreen
        self.present(clientVC, animated: true, completion: nil)
    }
    
}

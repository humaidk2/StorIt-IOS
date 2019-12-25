//
//  MenuTableViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 12/25/19.
//  Copyright © 2019 Cyber-Monkeys. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class MenuTableViewController: UITableViewController {

    @IBOutlet weak var profilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
       profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        
        //if user logs out
        Auth.auth().addStateDidChangeListener
        { (auth, user) in
            
            if user == nil {
              self.goToLogin()
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 6 { //logout
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
                print("user logged out")
                //dismiss(animated: true, completion: nil)
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
            
            //logs out google account
            GIDSignIn.sharedInstance().signOut()
        }
    }
    
    func goToLogin(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC:LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        
        //go to new screen in fullscreen
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }

}

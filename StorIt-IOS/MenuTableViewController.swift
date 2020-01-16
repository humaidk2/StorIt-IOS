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
        switch indexPath.row {
        case 0: //Profile
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let profileNC:ProfileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNC") as! ProfileNavigationController
            
            //go to new screen in fullscreen
            profileNC.modalPresentationStyle = .fullScreen
            self.present(profileNC, animated: true, completion: nil)
        case 1: //Payment Details
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let paymentDetailsNC:PaymentDetailsNavigationController = storyboard.instantiateViewController(withIdentifier: "PaymentDetailsNC") as! PaymentDetailsNavigationController
            
            //go to new screen in fullscreen
            paymentDetailsNC.modalPresentationStyle = .fullScreen
            self.present(paymentDetailsNC, animated: true, completion: nil)
        case 2: //Plans
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let plansNC:PlansNavigationController = storyboard.instantiateViewController(withIdentifier: "PlansNC") as! PlansNavigationController
            
            //go to new screen in fullscreen
            plansNC.modalPresentationStyle = .fullScreen
            self.present(plansNC, animated: true, completion: nil)
        case 3: //Help
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let helpNC:HelpNavigationController = storyboard.instantiateViewController(withIdentifier: "HelpNC") as! HelpNavigationController
            
            //go to new screen in fullscreen
            helpNC.modalPresentationStyle = .fullScreen
            self.present(helpNC, animated: true, completion: nil)
        case 4: //Terms & Conditions
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let termsAndConditionNC:TermsAndConditionNavigationController = storyboard.instantiateViewController(withIdentifier: "TermsAndConditionNC") as! TermsAndConditionNavigationController
            
            //go to new screen in fullscreen
            termsAndConditionNC.modalPresentationStyle = .fullScreen
            self.present(termsAndConditionNC, animated: true, completion: nil)
        case 5: //FAQs
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let faqsNC:FAQsNavigationController = storyboard.instantiateViewController(withIdentifier: "FAQsNC") as! FAQsNavigationController
            
            //go to new screen in fullscreen
            faqsNC.modalPresentationStyle = .fullScreen
            self.present(faqsNC, animated: true, completion: nil)
        case 6: //Logout
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
        default:
            print("Nothing pressed")
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

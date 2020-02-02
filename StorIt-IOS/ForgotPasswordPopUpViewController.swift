//
//  ForgotPasswordPopUpViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 1/25/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordPopUpViewController: UIViewController, SBCardPopupContent {
    
    var popupViewController: SBCardPopupViewController?
    
    var allowsTapToDismissPopupCard: Bool = true
    
    var allowsSwipeToDismissPopupCard: Bool = true
    
    @IBOutlet weak var emailTxt: UITextField!
    
    //let create initiate for popup
    static func create () -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ForgotPassword") as! ForgotPasswordPopUpViewController
        
        return storyboard
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //close the popup
    @IBAction func didTapCancel(_ sender: Any) {
        self.popupViewController?.close()
    }
    
    //recover account password
    @IBAction func didTapRecover(_ sender: Any) {
        guard let email = emailTxt.text, email != "" else {
            self.showToast(message: "Empty Email")
            return
        }
        
        resetPass(email: email, onSuccess: {
            self.showToast(message: "Email Sent")
            
            //add delay before it closes
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.popupViewController?.close()
            }
            
        }) { (errorMessage) in
            self.showToast(message: "Email Invalid")
        }
        
    }
    
    func resetPass(email : String, onSuccess: @escaping()-> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                onSuccess()
            }else{
                onError(error!.localizedDescription)
            }
            
        }
        
    }
    
    //show toast
    func showToast(message : String) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



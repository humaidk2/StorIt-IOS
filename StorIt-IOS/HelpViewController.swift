//
//  HelpViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 1/15/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    //variables
    @IBOutlet weak var submitSuggestionText: UITextView!
    @IBOutlet weak var submitBugText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for left bar button
        let backButton = UIBarButtonItem(image: UIImage(named: "back-24"), style: .plain, target: self, action: #selector(goBack))
        
        self.navigationItem.leftBarButtonItem = backButton
        
        //add design
        submitBugText.layer.borderColor = UIColor.lightGray.cgColor;
        submitBugText.layer.borderWidth = 0.5
        submitBugText.layer.cornerRadius = 5
        submitSuggestionText.layer.borderColor = UIColor.lightGray.cgColor;
        submitSuggestionText.layer.borderWidth = 0.5
        submitSuggestionText.layer.cornerRadius = 5
       
    }
    
    //Go back to Menu
    @objc func goBack(){
         //then go to profile page
          let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let tabBarVC:TabBarViewController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarViewController
          
          //go to new screen in fullscreen
         tabBarVC.modalPresentationStyle = .fullScreen
          self.present(tabBarVC, animated: true, completion: nil)
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

//for navigation controller
class HelpNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

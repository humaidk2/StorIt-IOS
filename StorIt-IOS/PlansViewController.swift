//
//  PlansViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 1/15/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit

class PlansViewController: UIViewController {

    //variables
    @IBOutlet weak var planOne: UIView!
    @IBOutlet weak var planTwo: UIView!
    @IBOutlet weak var planThree: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for left bar button
        let backButton = UIBarButtonItem(image: UIImage(named: "back-24"), style: .plain, target: self, action: #selector(goBack))
        
        self.navigationItem.leftBarButtonItem = backButton
        
        //border designs
        planOne.layer.borderColor = UIColor.lightGray.cgColor;
        planOne.layer.borderWidth = 0.5
        planOne.layer.cornerRadius = 5
        planTwo.layer.borderColor = UIColor.lightGray.cgColor;
        planTwo.layer.borderWidth = 0.5
        planTwo.layer.cornerRadius = 5
        planThree.layer.borderColor = UIColor.lightGray.cgColor;
        planThree.layer.borderWidth = 0.5
        planThree.layer.cornerRadius = 5
       
        //onclick for plan
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToPurchasePlan))
        planThree.addGestureRecognizer(tapGesture)
    }
    
    //Go back
    @objc func goBack(){
         //then go to profile page
          let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let tabBarVC:TabBarViewController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarViewController
          
          //go to new screen in fullscreen
         tabBarVC.modalPresentationStyle = .fullScreen
          self.present(tabBarVC, animated: true, completion: nil)
    }
    
    //go to purchase plan
    @objc func goToPurchasePlan(){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let purchasePlanNC:PurchasePlanNavigationController = storyboard.instantiateViewController(withIdentifier: "PurchasePlanNC") as! PurchasePlanNavigationController
        
        //go to new screen in fullscreen
        purchasePlanNC.modalPresentationStyle = .fullScreen
        self.present(purchasePlanNC, animated: true, completion: nil)
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
class PlansNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

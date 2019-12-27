//
//  ServerViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 12/25/19.
//  Copyright © 2019 Cyber-Monkeys. All rights reserved.
//

import UIKit

class ServerViewController: UIViewController {
    
    //variables
    @IBOutlet weak var fab : UIButton!

    //create object of SlideInTransition class
    let transition = SlideInTransition()

    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController  = storyboard?.instantiateViewController(withIdentifier: "MenuTVC")
            else{
                return
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self as! UIViewControllerTransitioningDelegate
        present(menuViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //floating action bar
        fab.layer.cornerRadius = fab.frame.height/2
        fab.layer.shadowOpacity = 0.25
        fab.layer.shadowRadius = 5
        fab.layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
}

//nav drawer
extension ServerViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}

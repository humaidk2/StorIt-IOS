//
//  ServerInformationViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 2/10/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit
import HGCircularSlider

class ServerInformationViewController: UIViewController {

    //variables
    @IBOutlet weak var serverStorage: UILabel!
    @IBOutlet weak var circularSlider: CircularSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for left bar button
        let backButton = UIBarButtonItem(image: UIImage(named: "back-24"), style: .plain, target: self, action: #selector(goBack))
        
        self.navigationItem.leftBarButtonItem = backButton
        
        circularSlider.endPointValue = 300 
        serverStorage.text = "\(Int(circularSlider.endPointValue)) MB"
    }
    
    //Go back to server info
    @objc func goBack(){
         dismiss(animated: true, completion: nil)
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
class ServerInformationNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

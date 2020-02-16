//
//  EditServerViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 2/16/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit
import HGCircularSlider

class EditServerViewController: UIViewController {

    @IBOutlet weak var slider: CircularSlider!
    @IBOutlet weak var serverStorage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        //for left bar button
        let backButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(goBack))
        
        self.navigationItem.leftBarButtonItem = backButton
        
        //for right bar button
        let saveButton = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveInfo))
        
        self.navigationItem.rightBarButtonItem = saveButton
        
        slider.endPointValue = 0
        serverStorage.text = "\(Int(slider.endPointValue)) MB"
        // Do any additional setup after loading the view.
    }
    
    //Go back to server info
    @objc func goBack(){
         dismiss(animated: true, completion: nil)
    }
    
    //save inputs
    @objc func saveInfo(){
        //
    }

    @IBAction func moveSlider(_ sender: CircularSlider) {
        let roundedValue = Int(sender.endPointValue.rounded())
        serverStorage.text = "\(roundedValue) MB"
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
class EditServerNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}



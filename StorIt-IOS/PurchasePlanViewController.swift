//
//  PurchasePlanViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 2/20/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit

class PurchasePlanViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var planThree: UIView!
    
    //number of rows in listview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    //initializer for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PurchasePlanTableViewCell
                
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //for left bar button
        let backButton = UIBarButtonItem(image: UIImage(named: "back-24"), style: .plain, target: self, action: #selector(goBack))
        
        self.navigationItem.leftBarButtonItem = backButton
        // Do any additional setup after loading the view.
        
        planThree.layer.cornerRadius = 5
    }
    
    //Go back
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
class PurchasePlanNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

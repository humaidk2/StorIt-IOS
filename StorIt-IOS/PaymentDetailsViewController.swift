//
//  PaymentDetailsViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 1/15/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit

class PaymentDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //how many row in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    //display attributes for each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PaymentDetailsTableViewCell
        
        let tapEdit = UITapGestureRecognizer(target: self, action: #selector(PaymentDetailsViewController.tapEdit))
        cell.editButton.isUserInteractionEnabled = true
        cell.editButton.addGestureRecognizer(tapEdit)
         
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for left bar button
        let backButton = UIBarButtonItem(image: UIImage(named: "back-24"), style: .plain, target: self, action: #selector(goBack))
        
        self.navigationItem.leftBarButtonItem = backButton
       
    }
    
    //Go back to Menu
    @objc func goBack(){
         dismiss(animated: true, completion: nil)
    }

    //onlick function of tapEdit
    @objc func tapEdit(sender:UITapGestureRecognizer){
        print("TAPPED EDIT")
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let editPaymentNC:EditPaymentDetailsNavigationController = storyboard.instantiateViewController(withIdentifier: "EditPaymentNC") as! EditPaymentDetailsNavigationController
        
        //go to new screen in fullscreen
        editPaymentNC.modalPresentationStyle = .fullScreen
        self.present(editPaymentNC, animated: true, completion: nil)
    }
    
    //when pressed add new payment button
    @IBAction func goToAddPayment(_ sender: Any) {
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addPaymentNC:AddCardNavigationController = storyboard.instantiateViewController(withIdentifier: "AddCardNC") as! AddCardNavigationController
        
        //go to new screen in fullscreen
        addPaymentNC.modalPresentationStyle = .fullScreen
        self.present(addPaymentNC, animated: true, completion: nil)
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
class PaymentDetailsNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

//
//  EditPaymentDetailsViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 2/20/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit

class EditPaymentDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //variables
    @IBOutlet weak var billingAddress: UITextView!
    @IBOutlet weak var cardholderName: UITextField!
    @IBOutlet weak var monthPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    let month = ["Month", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
    let year = ["Year", "2020", "2021", "2022", "2023"]
    
    // # of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // # of rows in a component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == monthPicker {
            return month.count
        } else if pickerView == yearPicker {
            return year.count
        }else{
            return 0
        }
    }
    
    //set title
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == monthPicker {
            return month[row]
        } else if pickerView == yearPicker{
            return year[row]
        } else {
            return ""
        }
    }
    
    //selected row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == monthPicker {
            if row == 0 {
                print("DONT PRINT THIS")
            }else {
                print(month[row])
            }
        } else if pickerView == yearPicker {
            if row == 0 {
                print("DONT PRINT THIS")
            }else {
                print(year[row])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //for left bar button
        let backButton = UIBarButtonItem(image: UIImage(named: "back-24"), style: .plain, target: self, action: #selector(goBack))
        
        self.navigationItem.leftBarButtonItem = backButton
        // Do any additional setup after loading the view.
        billingAddress.layer.borderWidth = 0.5
        billingAddress.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    //Go back
    @objc func goBack(){
         dismiss(animated: true, completion: nil)
    }
    
    //pressed save button
    @IBAction func pressedSave(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //pressed cancel button
    @IBAction func pressedCancel(_ sender: Any) {
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
class EditPaymentDetailsNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

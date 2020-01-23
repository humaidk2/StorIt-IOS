//
//  EditProfileViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 1/23/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class EditProfileViewController: UIViewController, UITextFieldDelegate {

    //variables
    @IBOutlet weak var editBirthdate: UITextField!
    @IBOutlet weak var editEmail: UITextField!
    @IBOutlet weak var editUsername: UITextField!
    @IBOutlet weak var editName: UITextField!
    var birthdate = ""
    var email = ""
    var username = ""
    var name = ""
    private var datePicker : UIDatePicker?
    let db = Firestore.firestore()
    var docRef = DocumentReference?.self
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //for left bar button
        let backButton = UIBarButtonItem(image: UIImage(named: "back-24"), style: .plain, target: self, action: #selector(goBack))
        
        self.navigationItem.leftBarButtonItem = backButton
        
        //for right bar button
        let saveButton = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveInfo))
        
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.editEmail.delegate = self
        self.editUsername.delegate = self
        self.editName.delegate = self
        
        //assign strings to text field
        editBirthdate.text = birthdate
        editEmail.text = email
        editUsername.text = username
        editName.text = name
        
        //add datepicker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(EditProfileViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        //remove datepicker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditProfileViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        editBirthdate.inputView = datePicker
    }
    
    //Go back to Menu
    @objc func goBack(){
         dismiss(animated: true, completion: nil)
    }
    
    //save inputs to firestore
    @objc func saveInfo(){
        print("i have pressed save")
        let birthDate = datePicker?.date
        let username = editUsername?.text
        let name = editName?.text
        let email = editEmail?.text
        let firebaseAuth = Auth.auth()
        var userId = firebaseAuth.currentUser!.uid
        
        self.db.collection("Users").document(userId).updateData([
            "Name": name,
            "Username": username,
            "Email":email,
            "Birthdate": birthDate
        ]) { err in
            if let err = err {
                print("Error updating document \(err)")
            } else{
                print("Document successfully updated")
            }
        }
        
        //then go to profile page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileNC:ProfileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNC") as! ProfileNavigationController
        
        //go to new screen in fullscreen
        profileNC.modalPresentationStyle = .fullScreen
        self.present(profileNC, animated: true, completion: nil)
    }
    
    //hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //hide keyboard when user presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        editEmail.resignFirstResponder()
        editUsername.resignFirstResponder()
        editName.resignFirstResponder()
        return(true)
    }
    
    //hide keyboard
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //change date to calendar
    @objc func dateChanged(datePicker : UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        editBirthdate.text = dateFormatter.string(from: datePicker.date)
        
        //removes date picker once user chooses a date
        view.endEditing(true)
        
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
class EditProfileNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

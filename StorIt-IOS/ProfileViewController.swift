//
//  ProfileViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 1/15/20.
//  Copyright © 2020 Cyber-Monkeys. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    //variables
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var txtBirthdate: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtUsername: UILabel!
    @IBOutlet weak var txtName: UILabel!
    private var datePicker : UIDatePicker?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePicImage.layer.cornerRadius = profilePicImage.frame.size.height/2
        
        //for left bar button
        let backButton = UIBarButtonItem(image: UIImage(named: "back-24"), style: .plain, target: self, action: #selector(goBack))
        
        self.navigationItem.leftBarButtonItem = backButton
        
        //Get data from fireStore
        let firebaseAuth = Auth.auth()
        var userId = firebaseAuth.currentUser!.uid
        db.collection("Users").document(userId).getDocument {
            (document, error) in
            if let document = document , document.exists {
                let username = document.get("Username")
                let email = document.get("Email")
                let name = document.get("Name")
                let firbirthdate = document.get("Birthdate") as! Timestamp
                let birthdate = firbirthdate.dateValue()
                
                //set username and email in nav drawer
                self.txtEmail.text = email as? String
                self.txtUsername.text = username as? String
                self.txtName.text = name as? String
                
                if birthdate == nil {
                    let date = Date()
                    let calendar = Calendar.current
                    let year = calendar.component(.year, from: date)
                    let day = calendar.component(.day, from: date)
                    let month = calendar.component(.month, from: date)
                    let myDate = "\(day)/\(month)/\(year)"
                    self.txtBirthdate.text = myDate
                }else {
                    let calendar = Calendar.current
                    let year = calendar.component(.year, from: birthdate)
                    let day = calendar.component(.day, from: birthdate )
                    let month = calendar.component(.month, from: birthdate )
                    let myDate = "\(day)/\(month)/\(year)"
                    self.txtBirthdate.text = myDate
                }
                
            } else {
                print("Document doesn't exist")
            }
        }
        
        //download prof pic
        setupProfPic()
       
    }

    //Go back to Menu
    @objc func goBack(){
         //then go to profile page
         let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let clientNC:ClientNavigationController = storyboard.instantiateViewController(withIdentifier: "ClientNC") as! ClientNavigationController
         
         //go to new screen in fullscreen
        clientNC.modalPresentationStyle = .fullScreen
         self.present(clientNC, animated: true, completion: nil)
    }
    
    //go to editprofile
    //send data to edit profile
    //using override func prepare
    @IBAction func goToEditProfile(_ sender: Any) {
        performSegue(withIdentifier: "goToEditProfile", sender: self)
    }
    
    //download prof image from firebase storage
    func setupProfPic(){
        let firebaseAuth = Auth.auth()
        var user = firebaseAuth.currentUser
        
        let url : URL? = user?.photoURL
        
        if url != nil{
            downloadPickTask(url: url!)
        }
        
    }
    
    //download url image and set to imageView
    private func downloadPickTask(url: URL){
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: url) { (data,response, error) in
            
            if let e = error {
                print("Error downloading")
            } else {
                if let res = response as? HTTPURLResponse {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        
                        DispatchQueue.main.async {
                            self.profilePicImage.image = image
                        }
                        
                    }
                    else{
                        print("Couldn't get image")
                    }
                } else {
                    print("Could not get response")
                }
            }
            
        }
        downloadPicTask.resume()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Have to connect to nav controller first then view controller
        let dest = segue.destination as? EditProfileNavigationController
        let destEditProf = dest?.viewControllers.first as? EditProfileViewController
        
        //send attribute to edit profile
        destEditProf?.name = txtName!.text!
        destEditProf?.username = txtUsername.text!
        destEditProf?.email = txtEmail!.text!
        destEditProf?.birthdate = txtBirthdate!.text!
        
    }
    

}

//for navigation controller
class ProfileNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

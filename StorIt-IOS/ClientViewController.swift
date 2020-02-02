//
//  ClientViewController.swift
//  StorIt-IOS
//
//  Created by Fidel Lim on 12/24/19.
//  Copyright © 2019 Cyber-Monkeys. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import MobileCoreServices //import docs

class ClientViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //variables
    @IBOutlet weak var sortByTxt: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var fab : UIButton!
    let transparentView = UIView()
    let sortByTableView = UITableView() //add new pop up
    let addNewTableView = UITableView()
    let moreOptionsTableView = UITableView()
    
    //For sortby popup
    let sortByImage: [UIImage] = [
        UIImage(systemName: "arrow.up")!,
        UIImage(systemName: "arrow.down")!,
        UIImage(systemName: "arrow.up")!,
        UIImage(systemName: "arrow.down")!
    ]
    let sortByList = [
        "Name","Name","Size","Size"
    ]
    //For more options popup
    let moreOptionsList = [
        "Folder","Share", "Download", "Move",
        "Duplicate", "Details", "Backup", "Remove"
    ]
    let moreOptionsImage: [UIImage] = [
        UIImage(systemName: "folder")!, UIImage(named: "icons8-shared-document-24")!,
        UIImage(named: "icons8-downloads-24")!, UIImage(named: "icons8-send-file-24")!,
        UIImage(named: "icons8-copy-30")!, UIImage(systemName: "info.circle")!,
        UIImage(named: "icons8-copy-30")!, UIImage(systemName: "trash")!
    ]
    
    let fileName = [
        "Folder","fidel.txt", "ex.txt", "ex.txt",
        "ex.txt", "ex.txt", "ex.txt", "ex.txt"
    ]
    let fileType: [UIImage] = [
        UIImage(named: "background_2")!, UIImage(named: "background_2")!,
        UIImage(named: "background_2")!, UIImage(named: "background_2")!,
        UIImage(named: "background_2")!, UIImage(named: "background_2")!,
        UIImage(named: "background_2")!, UIImage(named: "background_2")!
    ]
    
    //create object of SlideInTransition class
    let transition = SlideInTransition()
    
    //CollectionView for Client page
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fileName.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ClientCollectionViewCell
        
        cell.fileName.text = fileName[indexPath.row]
        cell.fileType.image = fileType[indexPath.row]
        cell.moreOptions.tag = indexPath.row
        let moreOptions = UITapGestureRecognizer(target: self, action: #selector(ClientViewController.tapMoreOptions))
        cell.moreOptions.isUserInteractionEnabled = true
        cell.moreOptions.addGestureRecognizer(moreOptions)
        return cell
    }
    
    //onlick function of moreOptions
    //popup slide up menu
    @objc func tapMoreOptions(sender:UITapGestureRecognizer){
        let window = UIApplication.shared.keyWindow //to access nav controller
            
            //change its color when pressed
            transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            transparentView.frame = self.view.frame
            window?.addSubview(transparentView)
            
            //create tableView
            let screenSize = UIScreen.main.bounds.size
            sortByTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 400)
            window?.addSubview(moreOptionsTableView)
            
            //to go back to original state
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickTransparentViewForMoreOptions))
            transparentView.addGestureRecognizer(tapGesture)
            
            transparentView.alpha = 0
            
            //animation
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.transparentView.alpha = 0.5
                self.moreOptionsTableView.frame = CGRect(x: 0, y: screenSize.height - 400, width: screenSize.width, height: 400)
            }, completion: nil)
        }

        //remove pop of from sortBy
        @objc func clickTransparentViewForMoreOptions(){
            let screenSize = UIScreen.main.bounds.size
            //animation
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.transparentView.alpha = 0
                self.moreOptionsTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 400)
            }, completion: nil)
        }
    
    //Pressing nav drawer icon
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController  = storyboard?.instantiateViewController(withIdentifier: "MenuTVC")
            else{
                return
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self as! UIViewControllerTransitioningDelegate
        present(menuViewController, animated: true)
        
        //Go back to Menu controller 
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        transition.dimmingView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        var layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        
        //divide 2 is for how many columns which is 2 columns
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/3)
        
        //sortByTableView initialized
        sortByTableView.isScrollEnabled = true
        sortByTableView.delegate = self as! UITableViewDelegate
        sortByTableView.dataSource = self as! UITableViewDataSource
        //create identifier
        sortByTableView.register(SortByTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //addNewTableView initialized
        addNewTableView.isScrollEnabled = true
        addNewTableView.delegate = self as! UITableViewDelegate
        addNewTableView.dataSource = self as! UITableViewDataSource
        //create identifier
        addNewTableView.register(AddNewTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //MoreOptionsTableView initialized
        moreOptionsTableView.isScrollEnabled = true
        moreOptionsTableView.delegate = self as! UITableViewDelegate
        moreOptionsTableView.dataSource = self as! UITableViewDataSource
        //create identifier
        moreOptionsTableView.register(MoreOptionsTableViewCell.self, forCellReuseIdentifier: "Cell")

        //floating action bar
        fab.layer.cornerRadius = fab.frame.height/2
        fab.layer.shadowOpacity = 0.25
        fab.layer.shadowRadius = 5
        fab.layer.shadowOffset = CGSize(width: 0, height: 10)
        
        //to make label clickable
        let tapSortBy = UITapGestureRecognizer(target: self, action: #selector(ClientViewController.tapSortBy))
        sortByTxt.isUserInteractionEnabled = true
        sortByTxt.addGestureRecognizer(tapSortBy)
    }
    
    //onlick function of tapSortBy
    //popup slide up menu
    @objc func tapSortBy(sender:UITapGestureRecognizer){
        let window = UIApplication.shared.keyWindow //to access nav controller
        
        //change its color when pressed
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        
        //create tableView
        let screenSize = UIScreen.main.bounds.size
        sortByTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 250)
        window?.addSubview(sortByTableView)
        
        //to go back to original state
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        transparentView.alpha = 0
        
        //animation
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.sortByTableView.frame = CGRect(x: 0, y: screenSize.height - 250, width: screenSize.width, height: 250)
        }, completion: nil)
    }

    //remove pop of from sortBy
    @objc func clickTransparentView(){
        let screenSize = UIScreen.main.bounds.size
        //animation
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.sortByTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 250)
        }, completion: nil)
    }
    
    //add new folder/ upload file
    //popup slide up menu
    @IBAction func addNew(_ sender: Any) {
        
        let window = UIApplication.shared.keyWindow //to access nav controller
        
        //change its color when pressed
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        
        //create tableView
        let screenSize = UIScreen.main.bounds.size
        addNewTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 180)
        
        //make tableview header
        let headerView: UIView = UIView.init(frame: CGRect(x: 0,y: 0,width: screenSize.width,height: 30))
        let labelView: UILabel = UILabel.init(frame: CGRect(x: 4,y: 5,width: screenSize.width,height: 24))
        labelView.text = "Create New"
        labelView.textAlignment = .center
        headerView.addSubview(labelView)
        addNewTableView.tableHeaderView = headerView
        window?.addSubview(addNewTableView) //add tableview to window
        
        //to go back to original state
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickTransparentViewForAddNew))
        transparentView.addGestureRecognizer(tapGesture)
        
        transparentView.alpha = 0
        
        //animation
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.addNewTableView.frame = CGRect(x: 0, y: screenSize.height - 180, width: screenSize.width, height: 180)
        }, completion: nil)
    }

    //remove pop of from addNew
    @objc func clickTransparentViewForAddNew(){
        let screenSize = UIScreen.main.bounds.size
        //animation
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.addNewTableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 180)
        }, completion: nil)
    }
    
}

//nav drawer
extension ClientViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
    
}

//sortby tableview
extension ClientViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numOfRowsInSec:Int!

        if tableView == addNewTableView {
            numOfRowsInSec = 1
        }
        else if tableView == sortByTableView{
            numOfRowsInSec = sortByList.count
        }else if tableView == moreOptionsTableView {
            numOfRowsInSec = moreOptionsList.count
        }

        return numOfRowsInSec
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView.isEqual(addNewTableView) {

            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddNewTableViewCell

            cell.folder.text = "Folder"
            cell.secureUpload.text = "Secure Upload"
            cell.upload.text = "Upload"
            cell.folderImage.image = UIImage(systemName: "folder")
            cell.secureUploadImage.image = UIImage(systemName: "lock.shield")
            cell.uploadImage.image = UIImage(named: "icons8-upload-24")
            
            let tapUpload = UITapGestureRecognizer(target: self, action: #selector(ClientViewController.tapUpload))
            cell.upload.isUserInteractionEnabled = true
            cell.upload.addGestureRecognizer(tapUpload)
            

            let tapSecureUpload = UITapGestureRecognizer(target: self, action: #selector(ClientViewController.tapSecureUpload))
            cell.secureUpload.isUserInteractionEnabled = true
            cell.secureUpload.addGestureRecognizer(tapSecureUpload)
            
            let tapFolder = UITapGestureRecognizer(target: self, action: #selector(ClientViewController.tapFolder))
            cell.folder.isUserInteractionEnabled = true
            cell.folder.addGestureRecognizer(tapFolder)
            
            return cell

        }
        else if tableView == sortByTableView{
            var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SortByTableViewCell

            cell.title.text = sortByList[indexPath.row]
            cell.settingImage.image = sortByImage[indexPath.row]
            
            return cell
            
        }else if tableView == moreOptionsTableView{
            var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MoreOptionsTableViewCell

            cell.title.text = moreOptionsList[indexPath.row]
            cell.settingImage.image = moreOptionsImage[indexPath.row]
            
            return cell
        }else{
            return UITableViewCell()
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            print("THIS IS ROW ONE")
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == addNewTableView {
            return 150
        }else {
            return 50
        }
        
    }
    
    //onlick function of tapUpload
    @objc func tapFolder(sender:UITapGestureRecognizer){
        print("TAPPED FOLDER")
    }
    
    //onlick function of tapUpload
    @objc func tapSecureUpload(sender:UITapGestureRecognizer){
        print("TAPPED SECURE UPLOAD")
        
        //import document
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePlainText as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false //allow one file at a time
        present(documentPicker, animated:true, completion: nil)
        
    }
    
    //onlick function of tapUpload
    @objc func tapUpload(sender:UITapGestureRecognizer){
        print("TAPPED UPLOAD")
        
        //import document
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePlainText as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false //allow one file at a time
        present(documentPicker, animated:true, completion: nil)
    }
}


extension ClientViewController: UIDocumentPickerDelegate {
    
    //import document
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileUrl = urls.first else {
            return
        }
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let sandboxFileURL = dir.appendingPathComponent(selectedFileUrl.path)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path){
            print ("file exists already")
        }else {
            
            do {
                try FileManager.default.copyItem(at: selectedFileUrl, to: sandboxFileURL)
                
                print("Copied file")
            }catch{
                print("Error: \(error)")
            }
            
        }
        
    }
     
}


//for navigation controller
class ClientNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

//
//  ViewController.swift
//  userBio
//
//  Created by Dan Nguyen on 2/3/20.
//
//  code from: https://www.youtube.com/watch?v=v8r_wD_P3B8 (The Swift Guy)

import Foundation
import UIKit
import Firebase

class PersonalInforController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var contactInforField: UITextField!
    @IBOutlet weak var contactMethodField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var bioField: UITextView!
    
    

    
    
    @IBAction func importImage(_ sender: AnyObject)
    {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    // upload the info into database
    @IBAction func tapped(_ sender: Any) {
        let db = Firestore.firestore()
        let image = myImageView.image
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "Name": nameField.text!,
            "Drexel ID": idField.text!,
            "Contact method": contactMethodField.text!,
            "Contact infor": contactInforField.text!,
            "Bio": bioField.text!
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }

        self.uploadProfileImage(image!) { url in
            
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        {
            myImageView.image = image
        }
        else
        {
            //Error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // from Replicode: https://youtu.be/gWZP0vDgMtg
    // upload the image to database
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        let storageRef = Storage.storage().reference().child("ss")
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
        if error == nil, metaData != nil {

            storageRef.downloadURL { url, error in
                completion(url)
                // success!
            }
            
            }
        else {
                // failed
                completion(nil)
            }
        }
        
    }
    
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

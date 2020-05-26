//
//  makeRequestViewController.swift
//  DragonNest
//
//  Created by Neil Duan on 2/14/20.
//  Copyright © 2020 CI4. All rights reserved.
//

import UIKit
import Firebase

class makeRequestViewController: UIViewController {

    @IBOutlet weak var activityField: UITextField!
    @IBOutlet weak var partyNumberField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapped(_ sender: Any) {
        let db = Firestore.firestore()
            
            // Add a new document with a generated ID
            var ref: DocumentReference? = nil
            ref = db.collection("activity").addDocument(data: [
                "request":activityField.text!,
                "party number": partyNumberField.text!
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
    }

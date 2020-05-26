//
//  RequestViewController.swift
//  DragonNest
//
//  Created by Neil Duan on 2/11/20.
//  Copyright © 2020 CI4. All rights reserved.
//

import UIKit
import Firebase

class RequestViewController: UIViewController {
    
    var requestList = [Request]()
    var searchedRequest = [Request]()
    var searching = false
    let segName = "ToDetail"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //  code from: https://youtu.be/ge56yTgnjKs (Simplified iOS)
        //  put the data from database to the search view controller
        
        let db = Firestore.firestore()
        
        db.collection("activity").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let requestObject = document.data()
                    let request:Request = Request(requestName: requestObject["request"] as? String,partyNumber: requestObject["party number"] as? String)
                    self.requestList.append(request)
                }
                self.tableView.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segName {
            let destVC = segue.destination as! TestViewController
            destVC.request = sender as? Request
            
        }
    }
    
}

//  code from: https://youtu.be/wVeX68Iu43E (Let Create An App)
// limits the activity shown on the view controller to the activity that user typed in
extension RequestViewController: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedRequest.count
        } else {
            return requestList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if searching {
            cell?.textLabel?.text = searchedRequest[indexPath.row].requestName
        } else {
            let request: Request
            request = requestList[indexPath.row]
            cell?.textLabel?.text = request.requestName
        }
        return cell!
    }
    
    // passing data between the view controllers
    // from Sean Allen, https://youtu.be/gN3FbNJ6_TY
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = requestList[indexPath.row]
        performSegue(withIdentifier: segName, sender: request)
    }
    
}

//  code from: https://youtu.be/wVeX68Iu43E (Let Create An App)
//  take the user typed-in input (activity), lowercase them and search the matching result from database
extension RequestViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedRequest = requestList.filter({$0.requestName!.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }

}

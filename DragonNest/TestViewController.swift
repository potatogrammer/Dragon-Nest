//
//  TestViewController.swift
//  DragonNest
//
//  Created by Neil Duan on 2/27/20.
//  Copyright © 2020 CI4. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var RequestField: UITextField!
    @IBOutlet weak var NumberField: UITextField!
    var request: Request?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        RequestField.text = request?.requestName
        NumberField.text = request?.partyNumber
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

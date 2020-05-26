//
//  Request.swift
//  DragonNest
//
//  Created by Neil Duan on 2/27/20.
//  Copyright © 2020 CI4. All rights reserved.
//

import Foundation
class Request {
    
    var requestName: String?
    var partyNumber: String?
    
    init(requestName:String?,partyNumber:String?) {
        self.requestName = requestName
        self.partyNumber = partyNumber
    }
}

//
//  Extensions.swift
//  TechnicalAssessmentTest
//
//  Created by Mihir Thakkar on 23/10/20.
//  Copyright © 2020 Mihir Thakkar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginViewModel
{
    var email : String!
    var password : String!
    
    init(email: String, password: String)
    {
        self.email = email
        self.password = password
    }
}


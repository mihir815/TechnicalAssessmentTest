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
    
    func validateFields(finished: (Bool) -> Void)
    {
        if(self.email?.isEmpty == false && self.password?.isEmpty == false)
        {
            if (self.email?.isEmail() == true)
            {
                let passwordString = self.password
                
                if (passwordString!.length >= 8 && passwordString!.length <= 15)
                {
                    finished(true)
                    return
                }
            }
        }
    }
}


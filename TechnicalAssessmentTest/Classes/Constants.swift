//
//  Constants.swift
//  TechnicalAssessmentTest
//
//  Created by Mihir Thakkar on 23/10/20.
//  Copyright © 2020 Mihir Thakkar. All rights reserved.
//

import Foundation
import BFKit
import SwiftyUserDefaults

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class Constants: NSObject {
    
    struct messages {
        static var unknownError = "Something went wrong, please try again later."
    }
    
    struct environment {
        
        struct production
        {
            static var BASE_URL = "TFbCzui9JSJl6IOu14FDN8NnK2jlieX5"
        }
        struct staging
        {
            static var BASE_URL = "VsapucD4ZMun6wbxcNH4aZ6S28kpDV74"
        }
        
        struct current
        {
            static var BASE_URL = production.BASE_URL
        }
    }
    
    struct GoogleAnalytics {
        static var Login = "Login"
        static var Dashboard = "Dashboard"
    }
    
    struct API
    {
        static var login = "/oauth/token"
    }
    
    struct color{
        static var colorPrimary = UIColor(string: "#2e5902")
        static var colorGreenLight = UIColor(string: "#3a7219")
        static var colorGreenDark = UIColor(string: "#2a5713")
        static var colorWhite = UIColor(string: "#ffffff")
        static var colorToolbar = UIColor(string: "#f8f8f8")
        static var colorToolbarText_Selected = UIColor(string: "#00511a")
        static var colorToolbarText_NotSelected = UIColor(string: "#43860e")
        static var colorButtonGreen = UIColor(string: "#43860e")
        static var colorListingSeparator = UIColor(string: "#DBDBDB")
        static var colorEditTextLine = UIColor(string: "#bababa")
    }
    
    struct customFont{
        
    }
}

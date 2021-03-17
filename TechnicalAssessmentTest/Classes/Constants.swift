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
            static var BASE_URL = "https://jsonplaceholder.typicode.com"
        }
        struct staging
        {
            static var BASE_URL = "https://jsonplaceholder.typicode.com"
        }
        
        struct current
        {
            static var BASE_URL = production.BASE_URL
        }
    }
    
    struct API
    {
        static var posts = "/posts"
    }
    
    struct GoogleAnalytics {
        static var Login = "Login"
        static var Dashboard = "Dashboard"
    }
    
    struct images
    {
        static var posts = UIImage(named: "posts")
        static var favourites = UIImage(named: "favourites")
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

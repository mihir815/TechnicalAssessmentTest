//
//  ViewController.swift
//  TechnicalAssessmentTest
//
//  Created by Mihir Thakkar on 15/03/21.
//

import UIKit

class DashboardViewController: UIViewController
{
    // MARK: -
    // MARK: Controller Lifecycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
        UIApplication.shared.statusBarStyle = .lightContent
       
        Utilities.trackScreenForGoogleAnalytics(screenName: Constants.GoogleAnalytics.Dashboard)
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.tintColor = UIColor.white
        navigationBar?.setNavigationBarProperties(navigationBar: navigationBar!)
        self.navigationItem.title = "Dashboard"
    }
}


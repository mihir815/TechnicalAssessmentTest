//
//  ViewController.swift
//  TechnicalAssessmentTest
//
//  Created by Mihir Thakkar on 15/03/21.
//

import UIKit
import SwiftyUserDefaults

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
        
        let rightBarButton = UIBarButtonItem()
        rightBarButton.target = self
        rightBarButton.action = #selector(onClickLogout)
        rightBarButton.title = "Logout"
        rightBarButton.style = .done
        rightBarButton.tintColor = Constants.color.colorWhite
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: -
    // MARK: Buttons Click Events
    
    @objc func onClickLogout()
    {
        Defaults[\.isLogin] = false
        
        let viewController =  appDelegate.myStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        appDelegate.window?.rootViewController = navigationController
    }
}


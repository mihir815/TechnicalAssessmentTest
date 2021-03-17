//
//  ViewController.swift
//  TechnicalAssessmentTest
//
//  Created by Mihir Thakkar on 15/03/21.
//

import UIKit
import SwiftyUserDefaults
import Alamofire
import SwiftyJSON

class DashboardViewController: UIViewController
{
    var postDataArray : NSMutableArray! = NSMutableArray()
    
    // MARK: -
    // MARK: Controller Lifecycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.getPostDataFromAPI()
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
    // MARK: API Methods
    
    func getPostDataFromAPI()
    {
        print("getPostDataFromAPI")
        
        Utilities.showActivityIndicator()
        
        let apiURL = Constants.environment.current.BASE_URL + Constants.API.posts
      
        var headers: HTTPHeaders = []
        headers.add(name: "Accept", value: "*/*")
        
        AFWrapper.requestGET(apiURL, params: nil, headers: headers, success: { (statusCode, responseJson) in
            
            Utilities.hideActivityIndicator()
            
            self.postDataArray.removeAllObjects()
            
            if(statusCode == 200)
            {
                var finalArray:[Any] = []
                
                print("Here response \(responseJson)")
                
                let responseArray = responseJson.array! as NSArray
                
                for post in responseArray
                {
                    let tempObject = JSON(post)
                   
                    let tempPostModel : PostDataModel = PostDataModel()
                    tempPostModel.userId = tempObject["userId"].intValue
                    tempPostModel.id = tempObject["id"].intValue
                    tempPostModel.title = tempObject["title"].stringValue
                    tempPostModel.body = tempObject["body"].stringValue
                    
                    print("tempPostModel.id \(tempPostModel.id) ==> \(tempPostModel.body!)")
                    finalArray.append(tempPostModel)
                }
                
                if (finalArray.count > 0)
                {
                    let sortedArray = finalArray.sorted
                    {
                        ($0 as! PostDataModel).id < ($1 as! PostDataModel).id
                     }
                    self.postDataArray.addObjects(from: sortedArray)
                }
            }
            else
            {
                Utilities.hideActivityIndicator()
                Utilities.showAlertMessage(Constants.messages.unknownError)
            }
            
        }) { (error) in
            Utilities.hideActivityIndicator()
            Utilities.showAlertMessage(Constants.messages.unknownError)
        }
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


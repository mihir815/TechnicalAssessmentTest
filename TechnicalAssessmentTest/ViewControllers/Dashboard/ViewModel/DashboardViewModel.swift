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

class DashboardViewModel
{
    var items : NSMutableArray! = NSMutableArray()
    var error: Error? = nil
    var refreshing = false
    
    func fetch(completion: @escaping () -> Void)
    {
        refreshing = true
        
        let apiURL = Constants.environment.current.BASE_URL + Constants.API.posts
      
        var headers: HTTPHeaders = []
        headers.add(name: "Accept", value: "*/*")
        
        AFWrapper.requestGET(apiURL, params: nil, headers: headers, success: { (statusCode, responseJson) in
            
            self.items.removeAllObjects()
            
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
                    finalArray.append(tempPostModel)
                }
                
                if (finalArray.count > 0)
                {
                    let sortedArray = finalArray.sorted
                    {
                        ($0 as! PostDataModel).id < ($1 as! PostDataModel).id
                     }
                    self.items.addObjects(from: sortedArray)
                }
                completion()
            }
            else
            {
                completion()
            }
        }) { (error) in
            self.error = error
            completion()
        }
    }
}


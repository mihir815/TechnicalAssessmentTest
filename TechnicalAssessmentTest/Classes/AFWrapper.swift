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

class AFWrapper: NSObject
{
    class func requestGET(_ strURL : String, params : Parameters?, headers : HTTPHeaders? , success:@escaping (Int, JSON) -> Void, failure:@escaping (Error) -> Void){
   
            AF.request(strURL, method: .get, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (responseObject) -> Void in
                
                  //print("Response Code",responseObject.response?.statusCode as Any)
                  
                  switch responseObject.result {
                          case .success:
                              let resJson = JSON(responseObject.value!)
                              success(responseObject.response!.statusCode, resJson)
                              case .failure:
                              let error : Error = responseObject.error!
                              failure(error)
                          }
              
          }
        }
}


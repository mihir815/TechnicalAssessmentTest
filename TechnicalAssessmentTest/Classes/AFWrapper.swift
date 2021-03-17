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
    class func requestPOST(_ strURL : String, params : Parameters?, headers : HTTPHeaders?,responseType: String , success:@escaping (Int, JSON) -> Void, failure:@escaping (Error) -> Void){
   
        if (responseType == "text")
        {
            AF.request(strURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
            .responseString { response in
                    //print("response: \(response)")
              switch response.result {
                      case .success:
                          let resJson = JSON(response.value!)
                          success(response.response!.statusCode, resJson)
                          case .failure:
                          let error : Error = response.error!
                          failure(error)
                      }
                }
        }
        else{
            AF.request(strURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (responseObject) -> Void in
              
              
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
    
    class func requestPOSTJSON(_ strURL : String, params : Parameters?, headers : HTTPHeaders?,responseType: String , success:@escaping (Int, JSON) -> Void, failure:@escaping (Error) -> Void){
   
        if (responseType == "text")
        {
            AF.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseString { response in
                    //print("response: \(response)")
              switch response.result {
                      case .success:
                          let resJson = JSON(response.value!)
                          success(response.response!.statusCode, resJson)
                          case .failure:
                          let error : Error = response.error!
                          failure(error)
                      }
                }
        }
        else{
            AF.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
              
              
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
    
    class func requestPATCHJSON(_ strURL : String, params : Parameters?, headers : HTTPHeaders?,responseType: String , success:@escaping (Int, JSON) -> Void, failure:@escaping (Error) -> Void){
   
        if (responseType == "text")
        {
            AF.request(strURL, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseString { response in
                    //print("response: \(response)")
              switch response.result {
                      case .success:
                          let resJson = JSON(response.value!)
                          success(response.response!.statusCode, resJson)
                          case .failure:
                          let error : Error = response.error!
                          failure(error)
                      }
                }
        }
        else{
            AF.request(strURL, method: .patch, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
              
              
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
    
    class func requestPUTJSON(_ strURL : String, params : Parameters?, headers : HTTPHeaders?,responseType: String , success:@escaping (Int, JSON) -> Void, failure:@escaping (Error) -> Void){
   
        if (responseType == "text")
        {
            AF.request(strURL, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseString { response in
                    //print("response: \(response)")
              switch response.result {
                      case .success:
                          let resJson = JSON(response.value!)
                          success(response.response!.statusCode, resJson)
                          case .failure:
                          let error : Error = response.error!
                          failure(error)
                      }
                }
        }
        else{
            AF.request(strURL, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
              
              
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
    
    class func requestGET(_ strURL : String, params : Parameters?, headers : HTTPHeaders?,responseType: String , success:@escaping (Int, JSON) -> Void, failure:@escaping (Error) -> Void){
   
        if (responseType == "text")
        {
            AF.request(strURL, method: .get, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
            .responseString { response in
                    //print("response: \(response)")
              switch response.result {
                      case .success:
                          let resJson = JSON(response.value!)
                          success(response.response!.statusCode, resJson)
                          case .failure:
                          let error : Error = response.error!
                          failure(error)
                      }
                }
        }
        else{
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
}


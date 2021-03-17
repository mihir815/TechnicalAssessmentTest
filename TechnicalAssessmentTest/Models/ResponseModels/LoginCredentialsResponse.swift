//
//  Credentials.swift
//  TechnicalAssessmentTest
//
//  Created by Mihir Thakkar on 07/11/20.
//  Copyright © 2020 Mihir Thakkar. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginCredentialsResponse : NSObject, NSCoding{

    var accessToken : String!
    var expiresIn : Int!
    var idToken : String!
    var refreshToken : String!
    var scope : String!
    var tokenType : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        accessToken = json["access_token"].stringValue
        expiresIn = json["expires_in"].intValue
        idToken = json["id_token"].stringValue
        refreshToken = json["refresh_token"].stringValue
        scope = json["scope"].stringValue
        tokenType = json["token_type"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accessToken != nil{
            dictionary["access_token"] = accessToken
        }
        if expiresIn != nil{
            dictionary["expires_in"] = expiresIn
        }
        if idToken != nil{
            dictionary["id_token"] = idToken
        }
        if refreshToken != nil{
            dictionary["refresh_token"] = refreshToken
        }
        if scope != nil{
            dictionary["scope"] = scope
        }
        if tokenType != nil{
            dictionary["token_type"] = tokenType
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        accessToken = aDecoder.decodeObject(forKey: "access_token") as? String
        expiresIn = aDecoder.decodeObject(forKey: "expires_in") as? Int
        idToken = aDecoder.decodeObject(forKey: "id_token") as? String
        refreshToken = aDecoder.decodeObject(forKey: "refresh_token") as? String
        scope = aDecoder.decodeObject(forKey: "scope") as? String
        tokenType = aDecoder.decodeObject(forKey: "token_type") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if accessToken != nil{
            aCoder.encode(accessToken, forKey: "access_token")
        }
        if expiresIn != nil{
            aCoder.encode(expiresIn, forKey: "expires_in")
        }
        if idToken != nil{
            aCoder.encode(idToken, forKey: "id_token")
        }
        if refreshToken != nil{
            aCoder.encode(refreshToken, forKey: "refresh_token")
        }
        if scope != nil{
            aCoder.encode(scope, forKey: "scope")
        }
        if tokenType != nil{
            aCoder.encode(tokenType, forKey: "token_type")
        }

    }

}

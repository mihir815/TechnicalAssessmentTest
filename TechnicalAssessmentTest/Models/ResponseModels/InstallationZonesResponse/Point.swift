//
//  Point.swift
//  Created on November 14, 2020

import Foundation
import SwiftyJSON


class Point : NSObject, NSCoding{

    var _id : String!
    var id : String!
    var path : NSArray!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        _id = json["_id"].stringValue
        id = json["id"].stringValue
        path = json["path"].arrayObject! as NSArray
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if _id != nil{
        	dictionary["_id"] = _id
        }
        if id != nil{
        	dictionary["id"] = id
        }
        if path != nil{
        	dictionary["path"] = path
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		_id = aDecoder.decodeObject(forKey: "_id") as? String
		id = aDecoder.decodeObject(forKey: "id") as? String
		path = aDecoder.decodeObject(forKey: "path") as? NSArray
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if _id != nil{
			aCoder.encode(id, forKey: "_id")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if path != nil{
			aCoder.encode(path, forKey: "path")
		}

	}

}

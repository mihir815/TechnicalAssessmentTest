//
//  Section.swift
//  Created on November 14, 2020

import Foundation
import SwiftyJSON


class Section : NSObject, NSCoding{

    var id : String!
    var name : String!
    var spots : [Spot]!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        id = json["_id"].stringValue
        name = json["name"].stringValue
        spots = [Spot]()
        let spotsArray = json["spots"].arrayValue
        for spotsJson in spotsArray{
            let value = Spot(fromJson: spotsJson)
            spots.append(value)
        }
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if id != nil{
        	dictionary["_id"] = id
        }
        if name != nil{
        	dictionary["name"] = name
        }
        if spots != nil{
        var dictionaryElements = [[String:Any]]()
        for spotsElement in spots {
        	dictionaryElements.append(spotsElement.toDictionary())
        }
        dictionary["spots"] = dictionaryElements
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		id = aDecoder.decodeObject(forKey: "_id") as? String
		name = aDecoder.decodeObject(forKey: "name") as? String
		spots = aDecoder.decodeObject(forKey: "spots") as? [Spot]
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "_id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if spots != nil{
			aCoder.encode(spots, forKey: "spots")
		}

	}

}

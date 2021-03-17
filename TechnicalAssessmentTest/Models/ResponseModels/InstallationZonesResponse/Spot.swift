//
//  Spot.swift
//  Created on November 14, 2020

import Foundation
import SwiftyJSON


class Spot : NSObject, NSCoding{

    var id : String!
    var position : Position!
    var sensor : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        id = json["_id"].stringValue
        let positionJson = json["position"]
        if !positionJson.isEmpty{
            position = Position(fromJson: positionJson)
        }
        sensor = json["sensor"].stringValue
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
        if position != nil{
        	dictionary["position"] = position.toDictionary()
        }
        if sensor != nil{
        	dictionary["sensor"] = sensor
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
		position = aDecoder.decodeObject(forKey: "position") as? Position
		sensor = aDecoder.decodeObject(forKey: "sensor") as? String
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
		if position != nil{
			aCoder.encode(position, forKey: "position")
		}
		if sensor != nil{
			aCoder.encode(sensor, forKey: "sensor")
		}

	}

}

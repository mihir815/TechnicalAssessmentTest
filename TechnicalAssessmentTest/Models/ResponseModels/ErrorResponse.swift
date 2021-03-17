//
//  Error.swift

import Foundation
import SwiftyJSON


class ErrorResponse : NSObject, NSCoding{

    var error : String!
    var errorDescription : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        error = json["error"].stringValue
        errorDescription = json["error_description"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if error != nil{
        	dictionary["error"] = error
        }
        if errorDescription != nil{
        	dictionary["error_description"] = errorDescription
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		error = aDecoder.decodeObject(forKey: "error") as? String
		errorDescription = aDecoder.decodeObject(forKey: "error_description") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if error != nil{
			aCoder.encode(error, forKey: "error")
		}
		if errorDescription != nil{
			aCoder.encode(errorDescription, forKey: "error_description")
		}

	}

}

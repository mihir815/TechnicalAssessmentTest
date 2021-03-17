//
//  ProjectDataResponse.swift
//  Created on November 14, 2020

import Foundation
import SwiftyJSON


class ProjectDataResponse : NSObject, NSCoding{

    var points : [Point]!
    var zones : [Zone]!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        points = [Point]()
        let pointsArray = json["points"].arrayValue
        for pointsJson in pointsArray{
            let value = Point(fromJson: pointsJson)
            points.append(value)
        }
        zones = [Zone]()
        let zonesArray = json["zones"].arrayValue
        for zonesJson in zonesArray{
            let value = Zone(fromJson: zonesJson)
            zones.append(value)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if points != nil{
        var dictionaryElements = [[String:Any]]()
        for pointsElement in points {
            dictionaryElements.append(pointsElement.toDictionary())
        }
        dictionary["points"] = dictionaryElements
        }
        if zones != nil{
        var dictionaryElements = [[String:Any]]()
        for zonesElement in zones {
            dictionaryElements.append(zonesElement.toDictionary())
        }
        dictionary["zones"] = dictionaryElements
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        points = aDecoder.decodeObject(forKey: "points") as? [Point]
        zones = aDecoder.decodeObject(forKey: "zones") as? [Zone]
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if points != nil{
            aCoder.encode(points, forKey: "points")
        }
        if zones != nil{
            aCoder.encode(zones, forKey: "zones")
        }

    }

}

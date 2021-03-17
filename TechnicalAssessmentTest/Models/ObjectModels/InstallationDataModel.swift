//
//  InstallationDataModel.swift

import Foundation
import SwiftyJSON

class InstallationDataModel : NSObject
{
    var installation : String!
    var light : Float!
    var moisture : Float!
    var salinity : Float!
    var spot : String!
    var temp : Float!
    var time : String!
    var projectData : ProjectDataModel!
}

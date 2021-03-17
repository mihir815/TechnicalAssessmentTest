//
//  ProjectDataModel.swift

import Foundation
import SwiftyJSON

class ProjectDataModel : NSObject
{
    var id : String!
    var name : String!
    var alias : String!
    var imageUrl : String!
    var supplier : String!
    var timezone : String!
    var data : ProjectDataResponse!
    //var zones : [Zone]!
}

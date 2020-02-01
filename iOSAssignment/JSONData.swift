//
//  JSONData.swift
//  iOSAssignment
//
//  Created by Neelam Gupta on 01/02/20.
//  Copyright © 2020 Neelam Gupta. All rights reserved.
//

import Foundation

struct JSONData:Decodable {
    var title:String
    var rows:[rowsData]?
}

struct rowsData:Decodable, Hashable{
    var title:String?
    var description:String?
    var imageHref:String!
}

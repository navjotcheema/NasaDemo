//
//  DataModel.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-10.
//

import Foundation
struct DataModel:Codable {
    var description:String
    var title :String
    var photographer:String
    var location : String
    var nasa_id :String
    var date_created :String
    var keywords:String
    var media_type:String
    var  center :String
}

//
//  NASAModel.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-10.
//

import Foundation

// Declare NasaImageSearchResponseModel struct
struct NasaImageSearchResponseModel: Codable {
    let collection: NasaCollection
}

// Declare NasaCollection struct
struct NasaCollection: Codable {
    let version: String
    let href: String
    let items: [NasaItem]
}

// Declare NasaItem struct

struct NasaItem: Codable, Equatable {
    static func == (lhs: NasaItem, rhs: NasaItem) -> Bool {
        lhs.href == rhs.href
    }
    
    let href: String
    let data: [NasaImageData]
    let links: [NasaImageLink]
}
// Declare NasaImageData struct

struct NasaImageData: Codable {
    let title: String
    let nasaId: String
    let dateCreated: String
    let description :String

    private enum CodingKeys: String, CodingKey {
        case description, title, nasaId = "nasa_id", dateCreated = "date_created"
    }
}
// Declare NasaImageLink struct

struct NasaImageLink: Codable {
    let href: String
    let rel: String
    let render: String
}

//Extension of NasaItem struct to add computed properties
extension NasaItem {
    var title: String? {
        data.first?.title
    }
    
    var description: String? {
        data.first?.description
    }
    
    var imageUrl: URL? {
        URL(string: links.first?.href ?? "")
    }
    var date :String? {
        
        let dateUtilty =  DateUtility()
        let formatterDate = dateUtilty.formatDate(dateString: data.first?.dateCreated ?? "")
        return formatterDate
    }
}

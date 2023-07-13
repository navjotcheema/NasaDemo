//
//  DateUtility.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-12.
//

import Foundation
class DateUtility {
    // DateFormatter for parsing the input date string
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    // DateFormatter for formatting the output date string
    let outputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    // Function for formatting the date string
    func formatDate(dateString: String) -> String {
        if let date = dateFormatter.date(from: dateString) {
            let formattedString = outputFormatter.string(from: date)
            return formattedString
        } else {
            return "No Created Date"
        }
    }
}

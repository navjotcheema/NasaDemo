//
//  DateUtility.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-12.
//

import Foundation
final class DateUtility {
    
    private static let dateFormatter = DateFormatter()
    
    private enum DateFormats: String {
        case complete = "yyyy-MM-dd'T'HH:mm:ssZ"
        case dateOnly = "yyyy-MM-dd"
    }
    
    // Function for formatting the date string
    static func formatDate(dateString: String) -> String {
        dateFormatter.dateFormat = DateFormats.complete.rawValue
        guard let date = dateFormatter.date(from: dateString) else {
            return "No Created Date"
        }
        dateFormatter.dateFormat = DateFormats.dateOnly.rawValue
        return dateFormatter.string(from: date)
    }
}

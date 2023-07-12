//
//  NasaDetailViewModel.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-12.
//

import SwiftUI

class NasaDetaiLViewModel:ObservableObject {
   @Published var item :NasaItem
    
    init(item: NasaItem) {
        self.item = item
    }
    let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
           return formatter
       }()
    
    let outputFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           return formatter
       }()
    func dateFormatter(dateString:String) -> String {
        print(dateString)
        if let date =  dateFormatter.date(from: dateString)
        {
            let formattedString =  outputFormatter.string(from: date)
            let stringDate = "Created Date: \(formattedString)"
            return stringDate

        }
        else
        {
            return "No Created Date"
        }
        
    }
    
}

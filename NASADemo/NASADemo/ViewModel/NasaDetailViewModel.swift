//
//  NasaDetailViewModel.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-12.
//

import SwiftUI

class NasaDetailViewModel:ObservableObject {
   @Published var item :NasaItem
    
    init(item: NasaItem) {
        self.item = item
    }
    }
    

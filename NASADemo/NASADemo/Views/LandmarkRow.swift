//
//  LandmarkRow.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-10.
//

import SwiftUI

struct LandmarkRow: View {
    var item:NASAItem
    var body: some View {

        HStack {
            if let imageUrl = item.imageUrl {
                NasaImage(imageURL: imageUrl)
                    .frame(width: 100, height: 100)
            } else {
                Text("No Image Found")
            }
            if let title =  item.title {
                Text(title)
            }
            else
            {
                Text("No Data found")
            }
                
        }
        
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        
        LandmarkRow(item: NASAItem(href: "", data:[], links:[]))
        
    }
}

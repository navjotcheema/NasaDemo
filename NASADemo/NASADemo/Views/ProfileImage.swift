//
//  ProfileImage.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-10.
//

import SwiftUI

struct ProfileImage: View {
    var image:Image
    var body: some View {
        image
           
            
            .shadow(radius: 7)
        
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(image: Image("profile"))
    }
}

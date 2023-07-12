//
//  NasaImage.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-11.
//

import SwiftUI

struct NasaImage: View {
    var imageURL: URL
      
      var body: some View {
          AsyncImage(url: imageURL) { image in
              image
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .shadow(radius: 7)
                  
          } placeholder: {
              // Placeholder view while the image is being loaded
              ProgressView()
          }
      }
  }

  struct NasaImage_Previews: PreviewProvider {
      static var previews: some View {
          // Example URL for preview
          let imageURL = URL(string: "https://example.com/image.jpg")!
          return NasaImage(imageURL:imageURL)
              .previewLayout(.fixed(width: 200, height: 200))
      }
  }

//
//  NasaImage.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-11.
//

import SwiftUI

struct NasaImage: View {
    
    //Url of the image
    var imageURL: URL
      
    /*
     // AsyncImage load image asycnhronously
     // resizeable is ised to make image resizeable
     // Placeholder view while the image is being loaded
     // Show a progress indicator while the image is loading
     */
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
          let imageURL = URL(string: Constants.exampleURL)!
          return NasaImage(imageURL:imageURL)
              .previewLayout(.fixed(width: 200, height: 200))
      }
  }

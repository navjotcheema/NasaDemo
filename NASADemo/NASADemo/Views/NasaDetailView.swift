//
//  LandmarkDetailView.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-10.
//

import SwiftUI

struct NasaDetailView: View {
    @StateObject var viewModel:NasaDetailViewModel
    /*
     // Display the NASA image if avilable
     // If no item found, display a text mesage
     // Display the title of the Nasa Item
     // Format and display the created date of the Nasa Item
     // Display description of teh Nasa Item
    */
     var body: some View {
        VStack {
            ScrollView {
            if let imageUrl = viewModel.item.imageUrl{
                NasaImage(imageURL: imageUrl)
                    .offset(y: 10)
                    .padding(.bottom, 0)
                    .frame(height: 300)
            } else {
                Text(Constants.noImageFound)
            }
           
            VStack(alignment: .leading) {
                Text(viewModel.item.title  ?? "")
                    .font(.title)
                
                
                
                if let createdDate =  viewModel.item.date {
                    Text(createdDate)
                        .font(.title3)
                }
              else
                {
                  Text("No Date Found")
              }
                Divider()
               
                Text(viewModel.item.description ?? "")
                }

            }
            .padding()
            
            Spacer()
        }
        .navigationTitle(Constants.detailViewTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Create a  preview with the dummy data for the Nasa Item  and view model
struct LandmarkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let item = NasaItem(href: "", data: [], links: [])
        let viewModel = NasaDetailViewModel(item: item)
        return NasaDetailView(viewModel: viewModel)
    }
}


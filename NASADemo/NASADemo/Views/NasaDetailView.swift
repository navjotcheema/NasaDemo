//
//  LandmarkDetailView.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-10.
//

import SwiftUI

struct ViewConstants {
    static let yAxis =  10.0
    static let height =  300.0
}
struct NasaDetailView: View {
    @StateObject var viewModel: NasaDetailViewModel
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
            if let imageUrl = viewModel.item.imageUrl {
                NasaImage(imageURL: imageUrl)
                    .offset(y: ViewConstants.yAxis)
                    .padding(.bottom, 0)
                    .frame(height: ViewConstants.height)
            } else {
                Text(Constants.noImageFound)
            }
            VStack(alignment: .leading) {
                Text(viewModel.item.title  ?? "")
                    .font(.title)
                if let createdDate =  viewModel.item.date {
                    Text(createdDate)
                        .font(.title3)
                } else {
                  Text(Constants.noDataFound)
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

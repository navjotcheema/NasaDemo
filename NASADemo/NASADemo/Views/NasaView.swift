//
//  NASAView.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-10.
//

import SwiftUI

struct NasaView: View {
    // Stateobject for the view model
    @StateObject var viewModel: NasaViewModel = NasaViewModel()
    // State Variable to store the search query
    @State private var query: String = ""
    /*
     // Textfield for entering the search query
     // Call  searchImages() when the query changes
     // Check if the model has items
     // Display a list of items from the view model
     // viewModel.fetchNextPageIfNeeded used to fetch the next page when an item appears
     */
    var body: some View {
        VStack {
            TextField("Search", text: $query, onCommit: searchImages)
                .onChange(of: query) { _ in
                    searchImages()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .offset(y: 10)
                if viewModel.hasItems {
                    List(viewModel.items, id: \.href) { item in
                        nasaCell(forItem: item)
                            .onAppear {
                                viewModel.fetchNextPageIfNeeded(forQuery: query, item: item)
                            }
                    }
                } else {
                    Text(Constants.noRecordsFound)
                        .foregroundColor(.gray)
                        .padding()
                }
                Spacer()
            }
        .navigationTitle(Constants.title)
        .task {
            searchImages()
        }
        }
    // Call nasaCell(forItem:) to create a view for each item

    func nasaCell(forItem item: NasaItem) -> some View {
        HStack {
            if let imageUrl = item.imageUrl {
                NasaImage(imageURL: imageUrl)
                    .frame(width: 100, height: 100)
            } else {
                Text(Constants.noImageFound)
            }
            if let title = item.title {
                Text(title)
            } else {
                Text(Constants.noDataFound)
            }
            NavigationLink("", destination: NasaDetailView(viewModel: NasaDetailViewModel(item: item)))
        }
        .padding()
    }
    // Call the view model's searchImages method to perform the search
    private func searchImages() {
        viewModel.searchImages(forQuery: query)
    }
}

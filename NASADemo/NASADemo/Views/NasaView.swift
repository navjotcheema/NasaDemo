//
//  NASAView.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-10.
//

import SwiftUI

struct NasaView: View {
    @StateObject var viewModel: NasaViewModel = NasaViewModel()
    @State private var query: String = ""
    
    var body: some View {
        VStack {
            TextField("Search", text: $query, onCommit: searchImages)
                .onChange(of: query) { _ in
                    searchImages()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .offset(y:10)
            
            if viewModel.hasItems {
                List(viewModel.items, id:\.href) { item in
                    nasaCell(forItem: item)
                        .onAppear {
                            viewModel.fetchNextPageIfNeeded(forQuery: query, item: item)
                        }
                }

            } else {
                Text("No Records Found")
                    .foregroundColor(.gray)
                    .padding()
            }
            Spacer()
        }
        .navigationTitle("NASA")
        .task {
            searchImages()
        }
    }
    
    func nasaCell(forItem item: NasaItem) -> some View {
        HStack {
            if let imageUrl = item.imageUrl {
                NasaImage(imageURL: imageUrl)
                    .frame(width: 100, height: 100)
            } else {
                Text("No Image Found")
            }
            
            if let title = item.title {
                Text(title)
            } else {
                Text("No Data Found")
            }
            NavigationLink("", destination: NasaDetailView(viewModel: NasaDetaiLViewModel(item: item)))
        }
        .padding()
    }
    
    private func searchImages() {
        viewModel.searchImages(forQuery: query)
    }
}

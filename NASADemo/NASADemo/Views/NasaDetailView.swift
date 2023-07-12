//
//  LandmarkDetailView.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-10.
//

import SwiftUI

struct NasaDetailView: View {
    @StateObject var viewModel:NasaDetaiLViewModel
    var body: some View {
        VStack {
           
            if let imageUrl = viewModel.item.imageUrl{
                NasaImage(imageURL: imageUrl)
                    .offset(y: 10)
                    .padding(.bottom, 0)
                    .frame(height: 300)
            } else {
                Text("No Image Found")
            }
            ScrollView {
            VStack(alignment: .leading) {
                Text(viewModel.item.title  ?? "")
                    .font(.title)
                
                Divider()
                
               
                let createdDate =  viewModel.dateFormatter(dateString: viewModel.item.date ?? "")
                Text(createdDate)
                    .font(.title2)
                Divider()
               
                Text(viewModel.item.description ?? "")
                }

            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Description")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LandmarkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let item = NasaItem(href: "", data: [], links: [])
        let viewModel = NasaDetaiLViewModel(item: item)
        return NasaDetailView(viewModel: viewModel)
    }
}


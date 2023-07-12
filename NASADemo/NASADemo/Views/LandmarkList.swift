//
//  LandmarkList.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-10.
//

import SwiftUI

struct LandmarkList: View {
    @State private var searchText = ""
    @State private var isSearching = false
    
    var filetredLandmarks :[Landmark]{
        if searchText.isEmpty {
            return landmarks
        }
        else {
            return landmarks.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    var body: some View {
        
            NavigationView {
                VStack {
                    SearchBar(text: $searchText, isSearching: $isSearching)
                List(landmarks.filter { searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(searchText) }) { landmark in
//                    NavigationLink(destination: LandmarkDetailView(landmark: landmark)) {
//                        LandmarkRow(landMark: landmark)
//                    }
                }
                .navigationTitle("LandMarks")
            }
        }
    }
    
    
}
struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
    }
}

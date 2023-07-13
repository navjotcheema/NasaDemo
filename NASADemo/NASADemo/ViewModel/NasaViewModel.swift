//
//  NASAViewModel.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-10.
//

import Foundation
class NasaViewModel: ObservableObject {

    // Array to hold Nasa Items
    @Published var items: [NasaItem] = []
    
    //Number of items to fetch in each page
    private var nextPageOffset = 10
    
    //Flag to track loading state
    private var isLoading = false
    
    //Currentpage number
    private var currentPage: Int = 1
    
    //API client for network requests
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    //Check if items array is not empty
    var hasItems: Bool {
        !items.isEmpty
    }
    
    //Method to fetch the next page of items if needed
    func fetchNextPageIfNeeded(forQuery query: String, item: NasaItem) {
        guard !isLoading,
            let index = items.firstIndex(of: item),
              items.count - index < nextPageOffset else { return }

        currentPage += 1
        fetchImages(forQuery: query)
    }
    
    //Method to search the images based on quesry
    func searchImages(forQuery query: String) {
        currentPage =  1
        fetchImages(forQuery: query)
    }
    
    //Method to fecth the images  for a given query and page
    func fetchImages(forQuery query: String) {
        isLoading = true
        let path = "search?q=\(query)&media_type=image&page=\(currentPage)"
        apiClient.searchImages(forPath: path) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let nasaModel):
                DispatchQueue.main.async {
                    let collections =  nasaModel.collection
                    if self?.currentPage == 1 {
                         self?.items = collections.items
                    } else {
                        self?.items.append(contentsOf: collections.items)
                    }
                }

            case .failure(let error):
                print("Error searching images: \(error.localizedDescription)")
            }
        }
    }
}

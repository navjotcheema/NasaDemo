//
//  NASAViewModel.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-10.
//

import Foundation
class NasaViewModel: ObservableObject {

 
    @Published var items: [NasaItem] = []
    private var nextPageOffset = 10
    private var isLoading = false
    private var currentPage: Int = 1
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    var hasItems: Bool {
        !items.isEmpty
    }
    
    func fetchNextPageIfNeeded(forQuery query: String, item: NasaItem) {
        guard !isLoading,
            let index = items.firstIndex(of: item),
              items.count - index < nextPageOffset else { return }

        currentPage += 1
        fetchImages(forQuery: query)
    }
    
    func searchImages(forQuery query: String) {
        currentPage =  1
        fetchImages(forQuery: query)
    }
    
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

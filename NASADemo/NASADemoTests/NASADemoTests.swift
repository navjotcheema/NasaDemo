//
//  NASADemoTests.swift
//  NASADemoTests
//
//  Created by Navjot Cheema on 2023-07-10.
//

import XCTest
@testable import NASADemo

fileprivate class MockApiClient: APIClientProtocol {
    
    var imagesPath: String?
    
    func searchImages(forPath path: String, completion: @escaping (Result<NasaImageSearchResponseModel, Error>) -> Void) {
        imagesPath = path
    }
    
}

final class NASADemoTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testNasaViewModel_hasItems() {
        let apiClient = MockApiClient()
        let viewModel = NasaViewModel(apiClient: apiClient)
        XCTAssertFalse(viewModel.hasItems)
        viewModel.items = [.init(href: UUID().uuidString, data: [], links: [])]
        XCTAssertTrue(viewModel.hasItems)
    }
    
    func testNasaViewModel_fetchNextPage() {
        let apiClient = MockApiClient()
        let viewModel = NasaViewModel(apiClient: apiClient)
        
        var items = [NasaItem]()
        for index in (1..<21) {
            items.append(NasaItem(href: "Item \(index)", data: [], links: []))
        }

        viewModel.items = items
        XCTAssertNil(apiClient.imagesPath)
        
        viewModel.fetchNextPageIfNeeded(forQuery: "Test", item: .init(href: "Item 5", data: [], links: []))
        XCTAssertNil(apiClient.imagesPath)
        
        viewModel.fetchNextPageIfNeeded(forQuery: "Test", item: .init(href: "Item 20", data: [], links: []))
        XCTAssertNotNil(apiClient.imagesPath)
    }

}

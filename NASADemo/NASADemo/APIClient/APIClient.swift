import Foundation

// MARK: - APIClientProtocol
protocol APIClientProtocol {
    func searchImages(forPath path: String, completion: @escaping (Result<NasaImageSearchResponseModel, Error>) -> Void)
}

// MARK: - APIClient

struct APIClient: APIClientProtocol {
    private let apiRequest: APIRequestProtocol
    let baseUrl = "https://images-api.nasa.gov"
    init(apiRequest: APIRequestProtocol = APIRequest()) {
        self.apiRequest = apiRequest
    }
    
    func searchImages(forPath path: String, completion: @escaping (Result<NasaImageSearchResponseModel, Error>) -> Void) {
        let urlString = "\(baseUrl)/\(path)"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "InvalidURL", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        apiRequest.get(url: url, completion: completion)
    }
}

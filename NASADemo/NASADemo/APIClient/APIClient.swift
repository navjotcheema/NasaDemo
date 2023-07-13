import Foundation

// MARK: - APIClientProtocol
protocol APIClientProtocol {
    // Functio to search Images
    func searchImages(forPath path: String, completion: @escaping (Result<NasaImageSearchResponseModel, Error>) -> Void)
}

// MARK: - APIClient

struct APIClient: APIClientProtocol {
    private let apiRequest: APIRequestProtocol
    init(apiRequest: APIRequestProtocol = APIRequest()) {
        self.apiRequest = apiRequest
    }
    // Function to search images using the Nasa Image API
    func searchImages(forPath path: String,
                      completion: @escaping (Result<NasaImageSearchResponseModel, Error>) -> Void) {
        let urlString = "\(Constants.baseUrl)/\(path)"
        if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
           // let url = URL(string: encodedString)
            guard let url = URL(string: encodedString) else {
                let error = NSError(domain: Constants.invalidUrl,
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: Constants.invalidUrl])
                completion(.failure(error))
                return
            }
            apiRequest.get(url: url, completion: completion)
        } else {
            let error = NSError(domain: Constants.invalidUrl,
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: Constants.invalidUrl])
            completion(.failure(error))
        }
    }
}

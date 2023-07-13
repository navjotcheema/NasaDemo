//
//  APIRequest.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-11.
//

import Foundation


enum HTTPMethod: String {
    case get = "GET"
}


// MARK: - APIRequestProtocol
protocol APIRequestProtocol {
    func get<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

// MARK: - APIRequest

struct APIRequest: APIRequestProtocol {
    func get<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: Constants.invalidResponse, code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.invalidHttpResponse])
                completion(.failure(error))
                return
            }
            
            let statusCode = httpResponse.statusCode
            guard 200..<300 ~= statusCode else {
                let error = NSError(domain: Constants.invalidStatusCode, code: statusCode, userInfo: [NSLocalizedDescriptionKey: Constants.invalidStatusCode])
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: Constants.emptyResponse, code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.emptyResponse])
                completion(.failure(error))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

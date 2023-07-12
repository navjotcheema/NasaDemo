//
//  APIRequest.swift
//  NASADemo
//
//  Created by Navjot Cheema on 2023-07-11.
//

import Foundation

// MARK: - APIRequestProtocol
protocol APIRequestProtocol {
    func get<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

// MARK: - APIRequest

struct APIRequest: APIRequestProtocol {
    func get<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "InvalidResponse", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"])
                completion(.failure(error))
                return
            }
            
            let statusCode = httpResponse.statusCode
            guard 200..<300 ~= statusCode else {
                let error = NSError(domain: "InvalidStatusCode", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Invalid status code"])
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "EmptyResponse", code: 0, userInfo: [NSLocalizedDescriptionKey: "Empty response"])
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

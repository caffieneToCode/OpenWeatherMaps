//
//  NetworkManager.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import Foundation

class NetworkManager {
    class func request<T: Codable>(router: NetworkRouter, completion: @escaping (Result<T, Error>) -> ()) {
        guard let urlRequest = makeURLRequest(from: router) else { return }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            ActivityIndicator.stop()
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                return
            }
            
            if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(responseObject))
            } else {
                completion(.failure(ParsingError.typeMismatch))
            }
            
            #if DEBUG
            printLogs(for: urlRequest, data: data)
            #endif
        }
        dataTask.resume()
    }
    
    class func makeURLRequest(from router: NetworkRouter) -> URLRequest? {
        guard let url = makeURL(from: router) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        return urlRequest
    }
    
    class func makeURL(from router: NetworkRouter) -> URL? {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path + router.version + router.endPoint
        if !router.parameters.isEmpty {
            components.queryItems = router.parameters
        }
        return components.url
    }
    
    class func printLogs(for urlRequest: URLRequest, data: Data) {
        if let urlString = urlRequest.url?.absoluteString,
           let method = urlRequest.httpMethod,
           let stringResponse = String(data: data, encoding: String.Encoding.utf8) {
            print("MethodType: \(method)")
            print("URL:\n\(urlString)")
            print("Response:\n\(stringResponse)")
        }
    }
}

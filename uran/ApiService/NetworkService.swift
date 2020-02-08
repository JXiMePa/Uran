//
//  NetworkService.swift
//  uran
//
//  Created by Tarasenko Jurik on 08.02.2020.
//  Copyright © 2020 Next Level. All rights reserved.
//

import UIKit

final class NetworkService {
    
    func request(searchText: String, page: Int, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParameters(searchText: searchText, page: page)
        let url = self.url(parameters: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String] {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID 2fbac6086a92b6d1478f9a6fd772f43ea21b4933f0f95d9d395470da6c32c764"
        return headers
    }
    
    private func prepareParameters(searchText: String, page: Int) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchText
        parameters["page"] = "\(page)"
        parameters["per_page"] = "30"
        return parameters
    }
    
    private func url(parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}

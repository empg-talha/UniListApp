//
//  NetworkManager.swift
//  University-List
//
//  Created by Talha Ahmad on 15/11/2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func getData<T: Codable>(url: URL, completion: @escaping (Result<T,UniAppNetworkError>)->())
}

enum UniAppNetworkError: Error {
    case decodingError
    case networkError
}

class NetworkManager: NetworkManagerProtocol{
    
    enum UniAPI {
        case list, detail
        
        var endpoint: String {
            switch self {
            case .list:
                return "http://universities.hipolabs.com/search?country=United+States"
            case .detail:
                return "http://universities.hipolabs.com/search?country=United+States"
            }
        }
    }
    
    func getData<T: Codable>(url: URL, completion: @escaping (Result<T, UniAppNetworkError>) -> ()) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.networkError))
            }
            else if data == nil {
                completion(.failure(.networkError))
            }
            else {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data!)
                    completion(.success(decodedData))
                    print(String(data: data!, encoding: .utf8)!)
                }
                catch {
                    completion(.failure(.decodingError))
                }
            }
            
            
        }.resume()
    }
}

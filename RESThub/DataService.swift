//
//  DataService.swift
//  RESThub
//
//  Created by Clayton Orman on 1/3/21.
//

import Foundation

class DataService {
    static let shared = DataService()
    fileprivate let baseURLString = "https://api.github.com"
    
    func fetchGists(completion: @escaping (Result<Any, Error>) -> Void) {
        // var baseURL = URL(string: baseURLString)
        // baseURL?.appendPathComponent("/somepath")
        
        // let composedURL = URL(string: "/somePath", relativeTo: baseURL)
        
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "api.github.com"
        componentURL.path = "/gists/public"
        
        guard let validURL = componentURL.url else {
            print("URL creation failed...")
            return
        }
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: validData, options: [])
                completion(.success(json))
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume() // Tasks start off in a suspended state, so resume is needed to fire the tasks
    }
}

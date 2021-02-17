//
//  LocationController.swift
//  labs-ios-starter
//
//  Created by Clayton Watkins on 2/16/21.
//  Copyright © 2021 Spencer Curtis. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noDataReturned
    case noToken
    case badDecode
    case tryAgain
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

class LocationController {
    // MARK: - Properties
    let profileController = ProfileController.shared
    var bearer: String?
    private let baseURL = URL(string: "https://labspt15-cityspire-a.herokuapp.com/")!
    static let shared = LocationController()
    
    // MARK: - Network Methods
    func getCityDetails(name: String, completion: @escaping (Result<Location, NetworkError>) -> Void) {
        self.bearer = profileController.bearer
        
        let requestURL = baseURL.appendingPathComponent("data/predict/" + name)
        print(requestURL.absoluteString)
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("Bearer \(bearer!)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                completion(.failure(.tryAgain))
            }
            
            if let response = response {
                print(response)
            }
            
            guard let data = data else {
                completion(.failure(.noDataReturned))
                return
            }
            
            do {
                let returnedLocation = try JSONDecoder().decode(Location.self, from: data)
                completion(.success(returnedLocation))
            } catch {
                print("Error getting Location: \(error)")
            }
        }
        task.resume()
    }
    

}

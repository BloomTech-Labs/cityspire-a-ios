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
    case badEncode
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

class LocationController {
    // MARK: - Properties
    let profileController = ProfileController.shared
    private var bearer: String?
    private let baseURL = URL(string: "https://labspt15-cityspire-a.herokuapp.com/")!
    static let shared = LocationController()
    
    // MARK: - Network Methods
    func getCityDetails(name: String, completion: @escaping (Result<Location, NetworkError>) -> Void) {
        self.bearer = profileController.bearer
        
        let requestURL = baseURL.appendingPathComponent("data/predict/" + name)
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("Bearer \(bearer!)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                completion(.failure(.tryAgain))
                return
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
    
    func saveCityAsFavorite(location: SavedLocation, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        self.bearer = profileController.bearer
        let requestURL = baseURL.appendingPathComponent("saved")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.addValue("Bearer \(bearer!)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode(location)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (_, _, error) in
                if let error = error {
                    print(error)
                    completion(.failure(.tryAgain))
                }
                completion(.success(true))
            }
            task.resume()
        } catch {
            print("Error encoding the city data: \(error)")
            completion(.failure(.badEncode))
        }
    }
    
    func getAllSavedFavoriteCities(completion: @escaping(Result<[ReturnedLocation], NetworkError>) -> Void) {
        self.bearer = profileController.bearer
        var request = URLRequest(url: baseURL.appendingPathComponent("saved"))
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue("Bearer \(bearer!)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error{
                print("Error getting all saved cities: \(error)")
                completion(.failure(.tryAgain))
            }
            
            guard let data = data else {
                completion(.failure(.noDataReturned))
                return
            }
            
            do{
                let returnedLocations = try JSONDecoder().decode([ReturnedLocation].self, from: data)
                completion(.success(returnedLocations))
            } catch {
                print("Error retrieving saved locations: \(error)")
            }
        }
        task.resume()
    }
    
    func deleteSavedFavoriteCity(id: Int, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        self.bearer = profileController.bearer
        var request = URLRequest(url: baseURL.appendingPathComponent("saved/\(id)"))
        request.httpMethod = HTTPMethod.delete.rawValue
        request.addValue("Bearer \(bearer!)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (_, _, _) in
            completion(.success(true))
        }
        task.resume()
    }

}

//
//  WeatherFramework.swift
//  WeatherFramework
//
//  Created by Simran on 27/03/24.
//

import Foundation
//import CoreLocation
public class WeatherFramework {
    public static func weatherInfo(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let apiKey = "fbf0dc30186edb4350f678c94a962ae8"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
//            guard let data = data, error == nil else {
//                completion(.failure(error!))
//                return
//            }
            if let error = error {
                            completion(.failure(error))
                            return
                        }
                        
                        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                            completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                            return
                        }
                        
                        guard let data = data else {
                            completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                            return
                        }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}

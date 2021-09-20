//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by beshssg on 19.09.2021.
//

import Foundation

struct NetworkManager {
    func weatherSetting(lat: Double, lon: Double, complition: @escaping (WeatherModel) -> Void) {
        let url = "https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(lon)"
        
        guard let requestURL = URL(string: url) else { return }
        
        var request = URLRequest(url: requestURL, timeoutInterval: Double.infinity)
        request.addValue("\(apiKey)", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            if let weather = parseJSON(data: data) {
                complition(weather)
            }
        }
        task.resume()
    }
    
    // MARK: Parsing JSON file:
    func parseJSON(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = WeatherModel(weatherData: weatherData) else {
                return nil
            }
            return weather
        
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}

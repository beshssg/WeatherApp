//
//  GetCityWeather.swift
//  WeatherApp
//
//  Created by beshssg on 19.09.2021.
//

import Foundation
import CoreLocation

func getCity(city: [String], complition: @escaping (Int, WeatherModel) -> Void) {
    for (index, item) in city.enumerated() {
        getCoordinate(city: item) { (coordinate, error) in
            guard let coordinate = coordinate, error == nil else { return }
            
            NetworkManager().weatherSetting(lat: coordinate.latitude, lon: coordinate.longitude) { (weather) in
                complition(index, weather)
            }
            
        }
    }
}

func getCoordinate(city: String, complition: @escaping (_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
        complition(placemark?.first?.location?.coordinate, error)
    }
}

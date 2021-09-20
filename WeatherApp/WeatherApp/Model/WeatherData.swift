//
//  WeatherData.swift
//  WeatherApp
//
//  Created by beshssg on 19.09.2021.
//

import Foundation

struct WeatherData: Decodable {
    let info: Info
    let fact: Fact
}

struct Info: Decodable {
    let url: String
}

struct Fact: Decodable {
    let temp: Double
    let icon: String
    let condition: String
    
    enum CodingKeys: String, CodingKey {
        case temp
        case icon
        case condition
    }
}

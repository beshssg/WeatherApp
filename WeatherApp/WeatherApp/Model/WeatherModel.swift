//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by beshssg on 19.09.2021.
//

import Foundation

struct WeatherModel {
    var name: String = "Город"
    var temperature: Double = 0.0
    var conditionCode: String = ""
    var url: String = ""
    var condition: String = ""
    var conditionString: String {
        switch condition {
        case "clear":
            return "Ясно☀️"
        case "partly-cloudy":
            return "Малооблачно🌤"
        case "cloudy":
            return "Облачно⛅️"
        case "overcast":
            return "Пасмурно🌥"
        case "drizzle":
            return "Морось☁️"
        case "light-rain":
            return "Малый дождь🌦"
        case "rain":
            return "Дождь🌧"
        case "moderate-rain":
            return "Умеренный дождь⛈"
        case "heavy-rain":
            return "Сильный дождь☔️"
        case "continuous-heavy-rain":
            return "Длительный дождь🌧☔️"
        case "showers":
            return "Ливень🌊"
        case "wet-snow":
            return "Дождь со снегом🌨"
        case "light-snow":
            return "Небольшой снег❄️"
        case "snow":
            return "Снег⛄️"
        case "snow-showers":
            return "Снегопад☃️"
        case "hail":
            return "Град🌨"
        case "thunderstorm":
            return "Гроза🌩"
        case "thunderstorm-with-rain":
            return "Дождь с грозой⛈"
        case "thunderstorm-with-hail":
            return "Гроза с градом⚡️"
        default:
            return "Загрузка..."
        }
    }
    
    init?(weatherData: WeatherData) {
        temperature = weatherData.fact.temp
        conditionCode = weatherData.fact.icon
        url = weatherData.info.url
        condition = weatherData.fact.condition
    }
    init() {}
}

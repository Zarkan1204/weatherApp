//
//  Model.swift
//  weatherApp
//
//  Created by Мой Macbook on 19.03.2024.
//

import Foundation

struct WeatherData: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
    
    static var placeholder: Self {
        return WeatherData(coord: nil, weather: nil, base: nil, main: nil,
                           visibility: nil, wind: nil, rain: nil, clouds: nil,
                           dt: nil, sys: nil, timezone: nil, id: nil, name: nil, cod: nil)
    }
}

struct Coord: Codable {
    let lon: Double?
    let lat: Double?
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Main: Codable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Double?
    let humidity: Int?
    let seaLevel: Double?
    let groundLevel: Double?
}

struct Wind: Codable {
    let speed: Double?
    let deg: Double?
    let gust: Double?
}

struct Rain: Codable {
    let hour1: Double
    
    enum CodingKeys: String, CodingKey {
        case hour1 = "1h"
    }
}

struct Clouds: Codable {
    let all: Int?
}

struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}

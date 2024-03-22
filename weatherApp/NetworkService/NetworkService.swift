//
//  NetworkService.swift
//  weatherApp
//
//  Created by Мой Macbook on 20.03.2024.
//

import Foundation
import Combine
import UIKit

final class NetworkService {
    
    static let shared = NetworkService()
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "f2329e144a722f773f2102096dc7e0d5"
    
    private func absoluteURL(city: String) -> URL? {
        let queryURL = URL(string: baseURL)!
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else { return nil }
        urlComponents.queryItems = [URLQueryItem(name: "appid", value: apiKey),
                                    URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "units", value: "metric")]
        return urlComponents.url
    }
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherData, Never> {
        guard let url = absoluteURL(city: city) else { return Just(WeatherData.placeholder).eraseToAnyPublisher() }
        print(url)
        return URLSession.shared.dataTaskPublisher(for:url)
            .map { $0.data }
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .catch { error in Just(WeatherData.placeholder)}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

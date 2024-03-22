//
//  ViewModel.swift
//  weatherApp
//
//  Created by Мой Macbook on 19.03.2024.
//

import Foundation
import Combine
import UIKit

final class ViewModel {
    
    @Published var city: String = "Tver"
    @Published var currentWeather = WeatherData.placeholder
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        $city
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { (city:String) -> AnyPublisher <WeatherData, Never> in
                NetworkService.shared.fetchWeather(for: city)
            }
            .assign(to: \.currentWeather , on: self)
            .store(in: &self.cancellableSet)
    }
}

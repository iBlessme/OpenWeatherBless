//
//  WeatherModel.swift
//  OpenWeatherBless
//
//  Created by iBlessme on 15.01.2022.
//

import Foundation
import Combine

class WeatherModel{
    static let shared = WeatherModel()
    @Published var weather: [Weather] = []
    private let baseaseURL = "https://api.openweathermap.org/data/2.5/weather"
        private let apiKey = "c64eb2aaa11ec500a5fac588c1f8c5d7"
        
        private func absoluteURL(city: String) -> URL? {
            let queryURL = URL(string: baseaseURL)!
            let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
            guard var urlComponents = components else { return nil}
            urlComponents.queryItems = [URLQueryItem(name: "appid", value: apiKey),
                                        URLQueryItem(name: "q", value: city),
                                        URLQueryItem(name: "units", value: "metric")]
            return urlComponents.url
        }
        
        // Выборка детальной информации о погоде для города city без Generic "издателя"
        func fetchWeather(for city: String) -> AnyPublisher<WeatherDetail, Never> {
            guard let url = absoluteURL(city: city) else {                  // 1
                return Just(WeatherDetail.placeholder)
                    .eraseToAnyPublisher()
            }
            return
                URLSession.shared.dataTaskPublisher(for:url)                  // 2
                    .map { $0.data }                                          // 3
                    .decode(type: WeatherDetail.self, decoder: JSONDecoder()) // 4
                    .catch { error in Just(WeatherDetail.placeholder)}        // 5
                    .receive(on: RunLoop.main)                                // 6
                    .eraseToAnyPublisher()                                    // 7
        }
        
    }


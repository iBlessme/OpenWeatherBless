//
//  TempViewmodel.swift
//  OpenWeatherBless
//
//  Created by iBlessme on 15.01.2022.
//

import Foundation
import Combine

final class TempViewModel: ObservableObject {
// input
   @Published var city: String = "Moscow"
   // output
   @Published var currentWeather = WeatherDetail.placeholder
   
   init() {
       $city
           .debounce(for: 0.3, scheduler: RunLoop.main)
           .removeDuplicates()
           .flatMap { (city:String) -> AnyPublisher <WeatherDetail, Never> in
               WeatherModel.shared.fetchWeather(for: city)
             }
           .assign(to: \.currentWeather , on: self)
           .store(in: &self.cancellableSet)
  }
   
   private var cancellableSet: Set<AnyCancellable> = []

}

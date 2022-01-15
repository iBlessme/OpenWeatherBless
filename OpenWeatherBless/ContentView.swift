//
//  ContentView.swift
//  OpenWeatherBless
//
//  Created by iBlessme on 15.01.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var weatherModel = TempViewModel()
    var body: some View {
        NavigationView{
            VStack{
                
                Image(systemName: "cloud")
                    .resizable()
                    .frame(width: 200, height: 150)
                    .padding()
                TextField("Название города", text: self.$weatherModel.city)
                    .padding()
                    .border(.black)
                    
                Text(
                    weatherModel.currentWeather.main?.temp != nil ? "Температура: \(Int((weatherModel.currentWeather.main?.temp!)!)) ºC" : " "
                )
                    .font(Font.system(size: 20))
                    .bold()
                Text(
                    weatherModel.currentWeather.main?.tempMin != nil ?
                    "Минимальная температура: \(Int((weatherModel.currentWeather.main?.tempMin!)!)) ºC" : " "
                )
                Text(
                    weatherModel.currentWeather.main?.tempMin != nil ?
                    "Максимальная температура: \(Int((weatherModel.currentWeather.main?.tempMax!)!)) ºC" : " "
                )
                Spacer()
            }
            .navigationTitle("Погода")
            }
            
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  WeatherView.swift
//  WeatherWithYou
//
//  Created by Miftahul Huda on 20/08/22.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold().font(.title)
                    
                    Text("Hari ini, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                WeatherViewInfo(weather: weather)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            WeatherViewBottom(weather: weather)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}


struct WeatherViewInfo: View {
    var weather: ResponseBody
    
    var body: some View {
        VStack {
            HStack {
                VStack(spacing: 20) {
                    Image(systemName: "cloud")
                        .font(.system(size: 40))
                    
                    Text("\(weather.weather[0].main)")
                }
                .frame(width: 150, alignment: .leading)
                
                Spacer()
                
                Text(weather.main.feelsLike.roundDouble() + "°")
                    .font(.system(size: 100))
                    .fontWeight(.bold)
                    .padding()
            }
            
            Spacer()
                .frame(height:  80)
            
            AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
            } placeholder: {
                ProgressView()
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct WeatherViewBottom: View {
    var weather: ResponseBody
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                Text("Weather now")
                    .bold()
                    .padding(.bottom)
                
                HStack(spacing: 0) {
                    WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + ("°")))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                HStack {
                    WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.bottom, 20)
            .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .background(.white)
            .cornerRadius(20, corners: [.topLeft, .topRight])
        }
    }
}


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}

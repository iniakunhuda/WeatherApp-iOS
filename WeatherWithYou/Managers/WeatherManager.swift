//
//  WeatherManager.swift
//  WeatherWithYou
//
//  Created by Miftahul Huda on 20/08/22.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    private var API_KEY = ""
    
    init() {
        if let apiKey = ProcessInfo.processInfo.environment["API_KEY_OPENWEATHERMAP"] {
            self.API_KEY = apiKey
        }
    }
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        let urlstring = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(API_KEY)"
        guard let url = URL(string: urlstring) else {
            fatalError("URL Error")
        }
        
        let urlReq = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlReq)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching data")
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        return decodedData
    }
    
    func getCurrentWeather(place: String) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(place)&units=metric&appid=\(API_KEY)") else {
            fatalError("URL Error")
        }
        
        let urlReq = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlReq)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching data")
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        return decodedData
    }
}

// Model of the response body we get from calling the OpenWeather API
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}

//
//  ModelData.swift
//  WeatherWithYou
//
//  Created by Miftahul Huda on 20/08/22.
//

import Foundation

var previewWeather: ResponseBody = ModelData().load("weatherData.json")

struct ModelData {
    func load<T: Decodable>(_ filename: String) -> T {
        
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("File \(filename) tidak ditemukan")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("File tidak dapat diload")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("File gabisa diparse. Error: \(error)")
        }
        
    }
}

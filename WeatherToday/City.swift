//
//  City.swift
//  WeatherToday
//
//  Created by kwon on 2021/08/06.
//

import Foundation

struct City: Codable {
    var cityName: String
    var state: Int
    var celsius: Double
    var rainfallProbability: Int
    
    var fahrenheit: Double {
        return round((Double(celsius * 9 / 5) + 32) * 10) / 10
    }
    
    var temperature: String {
        return "섭씨 \(celsius)도 / 화씨 \(fahrenheit)도"
    }
    
    var rainfall: String {
        return "강수확률 \(rainfallProbability)%"
    }
    
    enum CodingKeys: String, CodingKey {
        case state, celsius
        case cityName = "city_name"
        case rainfallProbability = "rainfall_probability"
    }
}

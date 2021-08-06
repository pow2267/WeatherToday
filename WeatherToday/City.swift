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
    
    enum CodingKeys: String, CodingKey {
        case state, celsius
        case cityName = "city_name"
        case rainfallProbability = "rainfall_probability"
    }
}

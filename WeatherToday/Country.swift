//
//  Country.swift
//  WeatherToday
//
//  Created by kwon on 2021/08/05.
//

import Foundation

struct Country: Codable {
    var koreanName: String
    var assetName: String
    
    enum CodingKeys: String, CodingKey {
        case koreanName = "korean_name"
        case assetName = "asset_name"
    }
}

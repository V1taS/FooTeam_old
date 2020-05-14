//
//  CurrentWeatherDater.swift
//  FooTeam
//
//  Created by Виталий Сосин on 13.05.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

struct CurrentWeatherDater: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
     
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
}

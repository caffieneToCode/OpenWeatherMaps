//
//  ResponseModel.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import Foundation

// MARK: - ResponseModel
struct WeatherResponseModel: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
    let temp: Double?
    let feelsLike: Int?
    let tempMin, tempMax: Double?
    let pressure, humidity, seaLevel, grndLevel: Int?
}

// MARK: - Sys
struct Sys: Codable {
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, weatherDescription, icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

//
//  ForecastResponseModel.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import Foundation

// MARK: - ForecastResponseModel
struct ForecastResponseModel: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [List]?
    let city: City?
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

// MARK: - List
struct List: Codable {
    let dt: Int?
    let main: MainClass?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility: Int?
    let pop: Double?
    let rain: Rain?
    let sys: Sys?
    let dtTxt: String?
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double?
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

enum Icon: String, Codable {
    case the03D = "03d"
    case the03N = "03n"
    case the04D = "04d"
    case the04N = "04n"
    case the10D = "10d"
    case the10N = "10n"
}

enum MainEnum: String, Codable {
    case clouds = "Clouds"
    case rain = "Rain"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

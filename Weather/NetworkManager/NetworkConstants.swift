//
//  NetworkConstants.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import Foundation

enum API {
    static let key = "fae7190d7e6433ec3a45285ffcf55c86"
}

enum Scheme {
    static let http = "http"
    static let https = "https"
}

enum HttpMethod {
    static let get = "GET"
}

enum Host {
    static let openWeatherData = "api.openweathermap.org"
    static let openWeatherMaps = "maps.openweathermap.org"
    static let helpPage = "www.apple.com"
}

enum Path {
    static let maps = "/maps"
    static let data = "/data"
}

enum Version {
    static let v2point0 = "/2.0"
    static let v2point5 = "/2.5"
}

enum EndPoint {
    static let weather = "/weather"
    static let forecast = "/forecast"
    static let hourlyForecast = "/forecast/hourly"
}

enum ParameterName {
    static let appId = "appid"
    static let lat = "lat"
    static let lon = "lon"
    static let city = "q"
    static let units = "units"
}

enum Units {
    static let metric = "metric"
}

enum ParsingError: String, Error {
    case typeMismatch = "Type Mismatch"
}

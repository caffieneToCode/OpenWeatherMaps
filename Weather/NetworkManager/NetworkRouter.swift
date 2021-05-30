//
//  NetworkRouter.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import Foundation

enum NetworkRouter {
    case weather(city: String?, lat: String?, lon: String?)
    case forecast(city: String)
    case hourlyForecast(city: String)
    case helpPage
    
    var scheme: String {
        switch self {
        case .weather, .forecast, .hourlyForecast, .helpPage:
            return Scheme.https
        }
    }
    
    var method: String {
        switch self {
        case .weather, .forecast, .hourlyForecast, .helpPage:
            return HttpMethod.get
        }
    }

    var host: String {
        switch self {
        case .weather, .forecast, .hourlyForecast:
            return Host.openWeatherData
        case .helpPage:
            return Host.helpPage
        }
    }
    
    var path: String {
        var path = String()
        switch self {
        case .weather, .forecast, .hourlyForecast:
            path = Path.data
        default:
            break
        }
        return path
    }
    
    var version: String {
        var version = String()
        switch self {
        case .weather, .forecast, .hourlyForecast:
            version = Version.v2point5
        default:
            break
        }
        return version
    }
    
    var endPoint: String {
        var endPoint = String()
        switch self {
        case .weather:
            endPoint = EndPoint.weather
        case .forecast:
            endPoint = EndPoint.forecast
        case .hourlyForecast:
            endPoint = EndPoint.hourlyForecast
        default:
            break
        }
        return endPoint
    }
    
    var parameters: [URLQueryItem] {
        var parameters = [URLQueryItem]()
        
        switch self {
        case .weather(let city, let lat, let lon):
            if let city = city {
                parameters.append(URLQueryItem(name: ParameterName.city, value: city))
            }
            if let lat = lat, let lon = lon {
                parameters.append(URLQueryItem(name: ParameterName.lat, value: lat))
                parameters.append(URLQueryItem(name: ParameterName.lon, value: lon))
            }
        case .forecast(let city), .hourlyForecast(let city):
            parameters.append(URLQueryItem(name: ParameterName.city, value: city))
        default:
            return [URLQueryItem]()
        }
        
        parameters.append(URLQueryItem(name: ParameterName.units, value: Units.metric))
        parameters.append(URLQueryItem(name: ParameterName.appId, value: API.key))
        
        return parameters
    }
}

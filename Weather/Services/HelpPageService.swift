//
//  HelpPageService.swift
//  Weather
//
//  Created by Ashish Verma on 30/05/21.
//

import Foundation

class HelpPageService {
    static func makeRequest(for router: NetworkRouter) -> URLRequest? {
        NetworkManager.makeURLRequest(from: router)
    }
}

//
//  ApiConfigurationProtocol.swift
//  
//
//  Created by Alper ACABEY on 10.05.2022.
//

import Foundation

public protocol ApiConfigurationProtocol {
    var baseUrl: String { get }
    var apiKey: String { get }
}

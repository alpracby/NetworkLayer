//
//  NetworkTask.swift
//  
//
//  Created by Alper ACABEY on 10.05.2022.
//

import Foundation

public protocol NetworkTask {
    associatedtype RequestModel: Codable
    associatedtype ResponseModel: Codable
    
    var endpoint: String { get }
    var httpMethod: HTTPMethodType { get }
    var request: RequestModel { get }
    
    init(request: RequestModel)
}

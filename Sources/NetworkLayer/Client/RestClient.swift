//
//  RestClient.swift
//  
//
//  Created by Alper ACABEY on 10.05.2022.
//

import Foundation

public class RestClient {
    
    // MARK: Internal Properties
    public var isReachable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    // MARK: Private Properties
    private let session: URLSession
    private let configuration: ApiConfigurationProtocol
    
    // MARK: Initializers
    public init(configuration: ApiConfigurationProtocol, session: URLSession) {
        self.configuration = configuration
        self.session = session
    }
    
    // MARK: Execution Methods
    @discardableResult
    public func execute<Task: NetworkTask>(task: Task, completion: @escaping (ResponseDataModel) -> Void) ->  URLSessionDataTask? {
        guard let requestUrl = self.request(task: task) else {
            completion(ResponseDataModel(statusCode: 999,
                                    error: NetworkError.custom(reason: "RequestUrl Error", title: "Error"),
                                    request: nil))
            return nil
        }
        
        let dataTask = session.dataTask(with: requestUrl) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(ResponseDataModel(statusCode: 999,
                                        error: NetworkError.custom(reason: "Response type cast error", title: "Error"),
                                        request: nil))
                
                return
            }
            
            completion(ResponseDataModel(statusCode: httpResponse.statusCode,
                                    data: data,
                                    error: error,
                                    request: requestUrl))
        }
        dataTask.resume()
        
        return dataTask
    }
    
    // MARK: Request Creation Methods
    private func request<Task: NetworkTask>(task: Task) -> URLRequest? {
        guard let parameters = try? task.request.asDictionary(),
              var urlComponents = URLComponents(string: configuration.baseUrl + task.endpoint) else { return nil }
        
        urlComponents.queryItems = parameters.compactMap {
            URLQueryItem(name: $0,
                         value: String(describing: $1))
        }
        urlComponents.queryItems?.append(URLQueryItem(name: "api_key",
                                                      value: configuration.apiKey))
        guard let url = urlComponents.url else { return nil }
        
        return URLRequest(url: url)
    }
}

//
//  APIManager.swift
//  MovieApp
//
//  Created by saurabh.a.rana on 15/06/22
//

import Foundation

/// Protocol used for configuration for service request
protocol Endpoint {
    var httpMethod: ReuestType { get }
    var baseURLString: String { get }
    var path: String { get }
    var headers: [String: Any]? { get }
    var body: [String: Any]? { get }
    var apikey: String { get }
}

/// Protocol used for different api call
protocol EndpopintAPICall {
    func getMoviesList(movieName: String,
                       page: String,
                       completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension EndpopintAPICall {
    func getMoviesList(movieName: String,
                       page: String,
                       completion: @escaping (Data?, URLResponse?, Error?) -> Void) {}
}

/// Configuration of URL
extension Endpoint {
    // a default extension that creates the full URL
    var url: String {
        return baseURLString + apikey + path
    }
}

enum ReuestType: String {
    case post = "POST"
    case get = "GET"
}

enum StatusReponse: String {
    case success = "success"
    case failure = "failed"
}

/// Configuration of Endpoint for service request
enum EndpointCases: Endpoint {
    case getMoviesList(movieName: String,
                       page: String)
    
    var httpMethod: ReuestType {
        switch self {
        case .getMoviesList:
            return .post
        }
    }
    
    var baseURLString: String {
        return Environment.current.baseUrlPath
    }
    
    var path: String {
        switch self {
        case .getMoviesList:
            return Environment.getMoviesList + "=\(EnvironmentConstant.type)"
        }
    }
    
    var apikey: String {
        switch self {
        case .getMoviesList:
            return Environment.apiKey + "=\(EnvironmentConstant.apikey)"
        }
    }
    
    var headers: [String: Any]? {
        switch self {
        case .getMoviesList:
            return [Constants.contentType: Environment.current.contentType,
                    Constants.accept: Environment.current.acceptJson
            ]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .getMoviesList(let movieName, let page):
            return ["s" : movieName,
                    "page" : page]
        }
    }
}

class ServiceRequest {
    static let shared = ServiceRequest()
    private init() { }
    
    /// Funciton to call servie request
    /// - Parameters:
    ///   - endpoint: instance of Endpoint wiht all config.
    ///   - completion: Response from api
    func request(endpoint: Endpoint,
                 completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession.shared
        
        // URL
        let queryString = queryItems(dictionary: endpoint.body ?? [:]).replacingOccurrences(of: "?", with: "&")
        let url = URL(string: endpoint.url + queryString)!
        var urlRequest = URLRequest(url: url)
        debugPrint("URL ------ \(urlRequest)")
        // Header fields
        endpoint.headers?.forEach({ header in
            urlRequest.setValue(header.value as? String,
                                forHTTPHeaderField: header.key)
        })
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
}

func queryItems(dictionary: [String:Any]) -> String {
    var components = URLComponents()
    components.queryItems = dictionary.map {
        URLQueryItem(name: $0, value: $1 as? String)
    }
    return ((components.url?.absoluteString)!)
}

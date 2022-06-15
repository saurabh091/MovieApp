//
//  Environment.swift
//  MovieApp
//
//  Created by saurabh.a.rana on 15/06/22.
//

import Foundation
import UIKit

enum Environment {
    case development
    case production             // Incase for Produciton Approach
}

/// URL and string used service request
enum EnvironmentConstant {
    //    apikey=b9bd48a6&type=movie
    static let baseURL = "http://www.omdbapi.com/?"
    static let contentType = "application/json"
    static let accept = "application/json"
    static let apikey = "b9bd48a6"
    static let type = "movie"
}

extension Environment {
    static var current: Environment {
        let targetName = Bundle.main.infoDictionary?["TargetName"] as? String
        switch targetName {
        case "MovieApp":
            return Environment.development
        default:
            return Environment.development
        }
    }
    
    var baseUrlPath: String {
        switch self {
        case .development: return EnvironmentConstant.baseURL
        case .production: return EnvironmentConstant.baseURL
        }
    }
    
    var apikey: String {
        switch self {
        case .development: return EnvironmentConstant.baseURL
        case .production: return EnvironmentConstant.baseURL
            
        }
    }
    
    var contentType: String {
        return EnvironmentConstant.contentType
    }
    
    var acceptJson: String {
        return EnvironmentConstant.accept
    }
}

/// Endpoint of url
extension Environment {
    static let getMoviesList = "&type"
    static let apiKey = "apikey"
}

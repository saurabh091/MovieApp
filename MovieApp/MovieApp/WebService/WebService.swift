//
//  WebService.swift
//  MovieApp
//
//  Created by Saurabh Rana on 15/06/22.
//

import Foundation
import UIKit

class WebService {
    
    let JSON_Url = "http://www.omdbapi.com/?apikey=b9bd48a6&type=movie&s=Marvel"
    ///&s=Marvel
    ///&page=1
    
    static let sharedInstance = WebService()
//    private let movieUrl = URL(string: JSON_Url)!
    
    func loadSources(completion :@escaping (MovieListModel?, Error?) -> ()) {
        URLSession.shared.dataTask(with: URL(string: JSON_Url)!) { data, _, error in

            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieList = try decoder.decode(MovieListModel.self, from: data)
//                    print(place.title ?? "no value")
                    DispatchQueue.main.async {
                        completion(movieList, nil)
                    }
                } catch let err {
                    print("Err", err)
                    DispatchQueue.main.async {
                        completion(nil, err)
                    }
                }
            }
            }.resume()
    }
    
}

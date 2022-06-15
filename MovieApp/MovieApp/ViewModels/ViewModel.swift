//
//  ViewModel.swift
//  MovieApp
//
//  Created by Saurabh Rana on 14/06/22.
//

import UIKit
import SDWebImage

class ViewModel: NSObject {
    
    func getMovieList(movieName: String, page: Int, completion: @escaping (MovieListModel?, Error?) -> Void) {
        let endPoint = EndpointCases.getMoviesList(movieName: movieName, page: String(page))
        ServiceRequest.shared.request(endpoint: endPoint) { data, response, error in
            if error == nil {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let movieList = try decoder.decode(MovieListModel.self, from: data)
                        completion(movieList, error)
                    } catch let err {
                        debugPrint("Error: ", err)
                        completion(nil, err)
                    }
                }
            }
            completion(nil, error)
        }
    }
}

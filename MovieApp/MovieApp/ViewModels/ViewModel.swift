//
//  ViewModel.swift
//  MovieApp
//
//  Created by Saurabh Rana on 14/06/22.
//

import UIKit
import SDWebImage

class ViewModel: NSObject {
    
//    var place: Place?
//    var rows: [Rows]?
//    var places: NSDictionary?
//
//    override init() {
//        super.init()
//    }
//
//    // Get places data from API
//    func fetchPlaces(completion: @escaping (Error?) -> ()) {
//        Webservice.sharedInstance.loadSources(completion: { place, error in
//            print(place as Any)
//            self.place = place
//            self.rows = place?.rows
//            completion(error)
//        })
//    }
//
//    func setNaigationTitle() -> String {
//        guard let title = place?.title else {
//            print("Empty navigation title")
//            return ""
//        }
//        return title
//    }
//
//    func numberOfItemInSection(section: Int) -> Int {
//        guard let numberOfRows = rows else {
//            return 0
//        }
//        return numberOfRows.count
//    }
//
//    // Returning Title
//    func titleForItemAtIndexPath(indexPath: IndexPath) -> String {
//        guard let item = rows?[indexPath.row] else {
//            return ""
//        }
//        return item.title ?? ""
//    }
//
//    // Returning Description
//    func descriptionForItemAtIndexPath(indexPath: IndexPath) -> String {
//        guard let item = rows?[indexPath.row] else {
//            return ""
//        }
//        return item.description ?? ""
//    }
//
//
//    // Function to Set image in ImageView
//    func setImage(cell: PlaceCell, indexPath: IndexPath) {
//        guard let items = rows else {
//            return
//        }
//
//        let urlString = items[indexPath.row].imageHref
//        let url = URL(string: urlString ?? "")
//        DispatchQueue.main.async {
//            cell.placeImageView.sd_setImage(with: url, placeholderImage: UIImage.init(named: PlaceHolder_Image), options: SDWebImageOptions(rawValue: 0), completed: nil)
//
//        }
//    }
}

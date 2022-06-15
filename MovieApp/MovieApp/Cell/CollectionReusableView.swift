//
//  CollectionReusableView.swift
//  MovieApp
//
//  Created by Saurabh Rana on 15/06/22.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    static let identifier = String(describing: CollectionReusableView.self)
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

//
//  MovieCVCell.swift
//  MovieApp
//
//  Created by Saurabh Rana on 15/06/22.
//

import UIKit
import SDWebImage

class MovieCVCell: UICollectionViewCell {
    static let identifier = String(describing: MovieCVCell.self)
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // To set name title.
    var movieName: String? {
        didSet {
            titleLabel.isHidden = movieName == nil ? true : false
            titleLabel.text = titleLabel.isHidden ? "" : movieName
        }
    }
    
    /// To set amount
    var moviePoster: String? {
        didSet {
            imageView.isHidden = moviePoster == nil ? true : false
            if let imageURl = moviePoster {
                let url = URL(string: imageURl)
                imageView.sd_setImage(with: url, placeholderImage: UIImage.init(named: "placeholder"), options: SDWebImageOptions(rawValue: 0), completed: nil)
            }
        }
    }
}

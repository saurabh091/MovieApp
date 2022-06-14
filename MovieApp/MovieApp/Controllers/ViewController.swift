//
//  ViewController.swift
//  MovieApp
//
//  Created by Saurabh Rana on 14/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getMovieList()
    }
    
    func getMovieList() {
        WebService.sharedInstance.loadSources { movieListModel, error in
            if error == nil {
                debugPrint("movie name : \(movieListModel?.movie)")
            }
        }
    }
    
    func setupView() {
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "MovieCVCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCell",
                                                      for: indexPath) as! MovieCVCell
        return cell
    }
}


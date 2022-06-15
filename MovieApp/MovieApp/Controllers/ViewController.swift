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
    private var viewModel: ViewModel?
    private var movieArray: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        setupView()
        getMovieList()
    }
    
    func getMovieList() {
        viewModel?.getMovieList(movieName: "Marvel", page: 2, completion: { [weak self] movieList, error in
            guard let self = self else { return }
            guard let list = movieList else {
                return
            }
            self.movieArray = list.search.count > 0 ? list.search : []
            debugPrint("Movie Lsit: \(self.movieArray)")
        })
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
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCVCell",
//                                                      for: indexPath) as! MovieCVCell
//        return cell
        return UICollectionViewCell()
    }
}


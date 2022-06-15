//
//  ViewController.swift
//  MovieApp
//
//  Created by Saurabh Rana on 14/06/22.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    private var viewModel: ViewModel?
    private var movieArray: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel()
        getMovieList()
    }
    
    func getMovieList() {
        viewModel?.getMovieList(movieName: "Marvel", page: 2, completion: { [weak self] movieList, error in
            guard let self = self else { return }
            guard let list = movieList else {
                return
            }
            self.movieArray = list.search.count > 0 ? list.search : []
            DispatchQueue.main.async {
                self.movieListCollectionView.reloadData()
                self.movieListCollectionView.layoutIfNeeded()
            }
            debugPrint("Movie Lsit: \(self.movieArray)")
        })
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCVCell.identifier,
                                                      for: indexPath) as! MovieCVCell
        cell.movieName = movieArray[indexPath.row].title
        cell.moviePoster = movieArray[indexPath.row].poster
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = view.frame.size.height
        let width = view.frame.size.width
        // in case you you want the cell to be 40% of your controllers view
        return CGSize(width: width * 0.46, height: height * 0.4)
    }
}


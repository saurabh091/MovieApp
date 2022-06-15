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
    var isLoading = false
    var loadingView: CollectionReusableView?
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register Loading Reuseable View
        let loadingReusableNib = UINib(nibName: CollectionReusableView.identifier, bundle: nil)
        movieListCollectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionReusableView.identifier)
        viewModel = ViewModel()
    }
    
    func getMovieList(name: String, pageNo: Int? = 1) {
        Spinner.start(style: .large,
                      baseColor: .black)
        viewModel?.getMovieList(movieName: name, page: pageNo!, completion: { [weak self] movieList, error in
            guard let self = self else { return }
            if let response = movieList?.response, response == "True", let currentMovies = movieList?.search {
                self.movieArray = self.movieArray + currentMovies
                if self.movieArray.count > 0 {
                    DispatchQueue.main.async {
                        self.movieListCollectionView.layoutIfNeeded()
                        self.movieListCollectionView.reloadData()
                    }
                    debugPrint("Movie List: \(self.movieArray)")
                } else {
                    debugPrint(Constants.noMovies)
                    DispatchQueue.main.async {
                        self.popupAlert(title: Constants.errorTitle,
                                        message: Constants.noMovies,
                                        actionTitles: [Constants.ok], actions:[{ action in
                        }])
                    }
                }
            } else {
                debugPrint("\(String(describing: movieList?.error))")
                DispatchQueue.main.async {
                    if let errorMessage = movieList?.error {
                        self.popupAlert(title: Constants.errorTitle,
                                        message: errorMessage,
                                        actionTitles: [Constants.ok], actions:[{ action in
                        }])
                    }
                }
            }
            
            DispatchQueue.main.async {
                Spinner.stop()
            }
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionReusableView.identifier, for: indexPath) as! CollectionReusableView
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter && self.movieArray.count > 0 {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movieArray.count - 1 && !self.isLoading {
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            pageNumber += 1
            if let searchText = searchBar.text {
                getMovieList(name: searchText, pageNo: pageNumber)
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.size.height
        let width = view.frame.size.width
        return CGSize(width: width * 0.46, height: height * 0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debugPrint(searchBar)
        
        // If movie name search is grater then 3 then only we will search on Database
        if searchText.count > 3 {
            self.movieArray = []
            self.pageNumber = 1
            self.isLoading = false
            getMovieList(name: searchText)
        }
    }
}

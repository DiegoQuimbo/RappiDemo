//
//  MoviesViewController.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 26/6/21.
//

import UIKit

class MoviesViewController: BaseViewController {
    
    // IBOutlets
    @IBOutlet weak var popularCategoryView: MoviesCategoryView!
    @IBOutlet weak var topRatedCategoryView: MoviesCategoryView!
    @IBOutlet weak var upComingCategoryView: MoviesCategoryView!
    var resultSearchController: UISearchController? = nil
    
    // Private Properties
    private let _viewModel = MoviesViewModel()
    
    private enum MoviesSegue: String {
        case ShowDetailMovie
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        loadMovies()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MoviesSegue.ShowDetailMovie.rawValue {
            let controller = segue.destination as! MovieDetailViewController
            controller.viewModel = _viewModel.buildMovieDetailViewModel()
        }
    }
}

// MARK: - Private Functions
private extension MoviesViewController {
    func setupView() {
        insertSearchBar()
        
        popularCategoryView.setUpViewWith(category: .popular, delegate: self)
        topRatedCategoryView.setUpViewWith(category: .topRated, delegate: self)
        upComingCategoryView.setUpViewWith(category: .upcoming, delegate: self)
        
        popularCategoryView.isHidden = true
        topRatedCategoryView.isHidden = true
        upComingCategoryView.isHidden = true
    }
    
    // Load UI data
    func refreshContentView() {
        popularCategoryView.isHidden = _viewModel.shouldHideCategoryView(category: .popular)
        popularCategoryView.movies = _viewModel.getPopularMovies()
        
        topRatedCategoryView.isHidden = _viewModel.shouldHideCategoryView(category: .topRated)
        topRatedCategoryView.movies = _viewModel.getTopRatedMovies()
        
        upComingCategoryView.isHidden = _viewModel.shouldHideCategoryView(category: .upcoming)
        upComingCategoryView.movies = _viewModel.getUpcomingMovies()
    }
    
    func insertSearchBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesSearchTable = storyboard.instantiateViewController(withIdentifier: "MovieSearchViewController") as! MovieSearchViewController
        moviesSearchTable.delegate = self
        resultSearchController = UISearchController(searchResultsController: moviesSearchTable)
        navigationItem.searchController = resultSearchController
        
        navigationItem.searchController?.searchBar.delegate = moviesSearchTable
        navigationItem.searchController?.searchBar.sizeToFit()
        navigationItem.searchController?.searchBar.placeholder = "Search Movies"
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController?.searchBar.searchTextField.textColor = .black
        
        definesPresentationContext = true
        
    }
    
    func loadMovies() {
        showProgressHud(view: view)
        _viewModel.loadMovies { error in
            self.hideProgressHud(view: self.view)
            if error == nil {
                self.refreshContentView()
            } else {
                self.showErrorView(title: "Error", message: "There was an error getting the movies")
            }
        }
    }
    
    func goToDetailMovieView(movie: Movie) {
        _viewModel.setMovieSelected(movie: movie)
        self.performSegue(withIdentifier: MoviesSegue.ShowDetailMovie.rawValue, sender: nil)
    }
}


extension MoviesViewController: MoviesCategoryViewDelegate {
    func movieHasSelected(movie: Movie) {
        goToDetailMovieView(movie: movie)
    }
}

// MARK: - MovieSearchViewDelegate
extension MoviesViewController: MovieSearchViewDelegate {
    func movieSelected(movie: Movie) {
        resultSearchController?.searchBar.text = ""
        goToDetailMovieView(movie: movie)
    }
}

//
//  MovieSearchViewController.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 29/6/21.
//

import UIKit
import RxSwift
import RxCocoa

protocol MovieSearchViewDelegate {
    func movieSelected(movie: Movie)
}

class MovieSearchViewController: BaseViewController {
    
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // Private properties
    private let _viewModel = MovieSearchViewModel()
    private var _movies = BehaviorRelay<[Movie]>(value: [])
    private let _disposeBag = DisposeBag()
    private let _cellIdentifier = "MovieInfoCell"
    
    // Public properties
    var delegate: MovieSearchViewDelegate?
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpRxTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Clear List
        _movies.accept([])
    }
    
    // MARK: - Private functions
    private func setUpRxTableView() {
        _movies.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: _cellIdentifier, cellType: MovieSearchTableViewCell.self)) { (row, movie, cell) in
                cell.nameLabel.text = movie.name
        }.disposed(by: _disposeBag)
        
        tableView.rx.modelSelected(Movie.self)
        .subscribe(onNext: { [weak self] movie in
            self?.delegate?.movieSelected(movie: movie)
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: _disposeBag)
    }
}

// MARK: - UISearchBarDelegate
extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        showProgressHud(view: self.view)
        _viewModel.searchMovies(input: text) {[weak self] movies in
            guard let self = self else { return }
            self.hideProgressHud(view: self.view)
            self._movies.accept(movies)
        }
    }
}



class MovieSearchTableViewCell: UITableViewCell {
    
    // IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

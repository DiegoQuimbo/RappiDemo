//
//  MoviesCategoryView.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 26/6/21.
//

import UIKit
import RxSwift
import RxCocoa

protocol MoviesCategoryViewDelegate {
    func movieHasSelected(movie: Movie)
}

class MoviesCategoryView: UIView {
    
    // IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // Public properties
    var movies: [Movie] = [] {
        didSet {
            _items.accept(movies)
        }
    }
    var delegate: MoviesCategoryViewDelegate?
    
    // Private properties
    private var _items = BehaviorRelay<[Movie]>(value: [])
    private let _disposeBag = DisposeBag()
    private let _cellIdentifier = "MovieCell"
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    // MARK: - Public Methods
    func setUpViewWith(category: MovieCategory, delegate: MoviesCategoryViewDelegate) {
        titleLabel.text = category.title
        self.delegate = delegate
    }
}

private extension MoviesCategoryView {
    // MARK: - Private Methods
    func initialize() {
        // Load Xib
        Bundle.main.loadNibNamed("\(Self.self)", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        
        setUpRxCollectionView()
    }
    
    func setUpRxCollectionView() {
        collectionView.register( UINib(nibName:"\(MovieCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: _cellIdentifier)
        
        _items.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: _cellIdentifier, cellType: MovieCollectionViewCell.self)) { (row, movie, cell) in
                cell.movie = movie
        }.disposed(by: _disposeBag)
        
        collectionView.rx.modelSelected(Movie.self)
        .subscribe(onNext: { [weak self] movie in
            self?.delegate?.movieHasSelected(movie: movie)
            
        }).disposed(by: _disposeBag)
    }
}

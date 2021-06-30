//
//  MovieDetailViewController.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 28/6/21.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailViewController: BaseViewController {
    
    // IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // Public vars
    var viewModel: MovieDetailViewModel?
    
    // Private vars
    private var _videos = BehaviorRelay<[MovieVideo]>(value: [])
    private let _disposeBag = DisposeBag()
    private let _cellIdentifier = "VideoCell"
    
    private enum MovieDetailSegue: String {
        case ShowPlayVideo
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getMovieVideos()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MovieDetailSegue.ShowPlayVideo.rawValue {
            let controller = segue.destination as! PlayVideoViewController
            controller.video = viewModel?.getVideoSelected()
        }
    }
}

// MARK: - Private Functions
private extension MovieDetailViewController {
    func setupView() {
        titleLabel.text = viewModel?.title
        subtitleLabel.text = viewModel?.subtitle
        
        setUpRxTableView()
    }
    
    func getMovieVideos() {
        viewModel?.getVideosFromAPI(completion: { [weak self] error in
            guard let self = self else { return }
            guard error == nil else {
                self.showErrorView(title: "Error", message: "There was an error getting the movie videos")
                return
            }
            self._videos.accept(self.viewModel?.movieVideos ?? [])
            
        })
    }
    
    func setUpRxTableView() {
        // Remove empty cells
        tableView.tableFooterView = UIView()
        
        _videos.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: _cellIdentifier, cellType: VideoTableViewCell.self)) { (row, video, cell) in
                cell.video = video
        }.disposed(by: _disposeBag)
        
        tableView.rx.modelSelected(MovieVideo.self)
        .subscribe(onNext: { [weak self] video in
            self?.viewModel?.setVideoSelected(video: video)
            self?.performSegue(withIdentifier: MovieDetailSegue.ShowPlayVideo.rawValue, sender: nil)
        }).disposed(by: _disposeBag)
    }
}

//
//  PlayVideoViewController.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 28/6/21.
//

import UIKit
import youtube_ios_player_helper

class PlayVideoViewController: UIViewController {

    // IBOutlets
    @IBOutlet var playerView: YTPlayerView!
    
    // Public vars
    var video: MovieVideo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadVideoInView()
    }
    
    private func loadVideoInView() {
        guard let keyVideo = video?.key else {
            return
        }
        print(keyVideo)
        playerView.load(withVideoId: keyVideo)
    }
}

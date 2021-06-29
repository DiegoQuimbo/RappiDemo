//
//  MovieCollectionViewCell.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 27/6/21.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    // IBOutlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // Public Vars
    var movie: Movie? {
        didSet {
            guard let movieObj = movie else { return }
        
            if let imagePath = movieObj.imagePath  {
                let imageURL = URL(string: imagePath)
                backgroundImageView.kf.setImage(with: imageURL)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

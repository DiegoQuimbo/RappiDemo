//
//  VideoTableViewCell.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 28/6/21.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    // IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    
    // Public Vars
    var video: MovieVideo? {
        didSet {
            guard let videoObj = video else { return }
            
            nameLabel.text = videoObj.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

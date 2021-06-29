//
//  MovieVideo.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 28/6/21.
//

import Foundation
import SwiftyJSON

enum VideoSource: String {
    case youtube = "YouTube"
    case other = "Other"
}

struct MovieVideo {
    // MARK: - Private identifiers
    private let _ID = "id"
    private let _KEY = "key"
    private let _NAME = "name"
    private let _SITE = "site"
    
    let id: String
    let key: String?
    let name: String?
    let site: VideoSource
    
    // MARK: - Initializers
    init(jsonObject: JSON) {
        id = jsonObject[_ID].string ?? ""
        key = jsonObject[_KEY].string ?? ""
        name = jsonObject[_NAME].string
        let source = jsonObject[_SITE].string ?? ""
        site = VideoSource(rawValue: source) ?? .other
    }
}

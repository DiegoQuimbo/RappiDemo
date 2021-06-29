//
//  String.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 28/6/21.
//

import Foundation

extension String {
    func encodingQuery() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}

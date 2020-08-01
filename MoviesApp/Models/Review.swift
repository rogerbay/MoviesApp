//
//  Review.swift
//  MoviesApp
//
//  Created by Roger Lacson on 6/21/20.
//  Copyright © 2020 Roger Lacson. All rights reserved.
//

import Foundation

struct Review: Codable {
    var id: UUID?
    var title: String
    var body: String
    var movie: Movie?
}

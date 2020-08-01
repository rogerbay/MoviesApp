//
//  Review.swift
//  MoviesApp
//
//  Created by Mohammad Azam on 6/21/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

struct Review: Codable {
    var id: UUID?
    var title: String
    var body: String
    var movie: Movie?
}

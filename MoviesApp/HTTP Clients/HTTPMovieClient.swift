//
//  HTTPMovieClient.swift
//  MoviesApp
//
//  Created by Roger Lacson on 6/16/20.
//  Copyright © 2020 Roger Lacson. All rights reserved.
//

import Foundation

class HTTPMovieClient: ObservableObject {
    
    @Published var movies: [Movie] = [Movie]()
    @Published var reviews: [Review]? = [Review]()
    
    
    func getReviewsByMovie(movie: Movie) {
        
        guard let uuid = movie.id,
            let url = URL(string: "http://localhost:8080/movies/\(uuid.uuidString)/reviews") else {
                fatalError("URL is not defined!")
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            let decodedReviews = try? JSONDecoder().decode([Review].self, from: data)
            
            if let decodedReviews = decodedReviews {
                DispatchQueue.main.async {
                     self.reviews = decodedReviews
                }
            }
            
            
        }.resume()
        
    }
    
    func deleteMovie(movie: Movie, completion: @escaping (Bool) -> Void) {
        
        guard let uuid = movie.id,
            let url = URL(string: "http://localhost:8080/movies/\(uuid.uuidString)") else {
                  fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let _ = data, error == nil else {
                           return completion(false)
            }
            
            completion(true)
            
        }.resume()
        
    }
    
    func getAllMovies() {
        
        guard let url = URL(string: "http://localhost:8080/movies") else {
            fatalError("URL is not defined!")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            let movies = try? JSONDecoder().decode([Movie].self, from: data)
            if let movies = movies {
                DispatchQueue.main.async {
                    self.movies = movies
                }
            }
        }.resume()
        
    }
    
    func saveMovie(name: String, poster: String, completion: @escaping (Bool) -> Void) {
       
        guard let url = URL(string: "http://localhost:8080/movies") else {
            fatalError("URL is not defined!")
        }
        
        let movie = Movie(title: name, poster: poster)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(movie)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let _ = data, error == nil else {
                return completion(false)
            }
            
            completion(true)
            
        }.resume()
        
    }
    
    func saveReview(review: Review, completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "http://localhost:8080/reviews") else {
            fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(review)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let _ = data, error == nil else {
                return completion(false)
            }
            
            completion(true)
            
        }.resume()
        
    }
    
}

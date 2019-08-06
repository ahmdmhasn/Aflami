//
//  MovieDetailsPresenter.swift
//  Aflami
//
//  Created by Ahmed M. Hassan on 8/6/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit

class MovieDetailsPresenter: NSObject {
    
    var delegate: MovieDetailsDelegate!
    
    let networkManager = NetworkManager.shared
    
    var trailers = [Trailer]()
    
    var movie: Movie {
        didSet {
            updateMovieUI()
        }
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func updateMovieUI() {
        //delegate.updateMovieImage(image: movie.posterPath)
        delegate.updateMovieRate(value: movie.rating)
        delegate.updateMovieName(text: movie.title)
        delegate.updateMovieDescription(text: movie.overview)
        delegate.updateMovieReleaseDate(text: movie.releaseDate)
    }
    
    func getTrailers(completion: @escaping ()->()) {
        networkManager.getTrailers(movieId: movie.id) { [weak self] (trailers) in
            guard let trailers = trailers else {
                completion()
                return
            }
            
            self?.trailers = trailers
            self?.delegate.reloadTrailers()
        }
    }
}

extension MovieDetailsPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trailers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trailersCell", for: indexPath)
        cell.textLabel?.text = trailers[indexPath.row].name
        return cell
    }
    
}

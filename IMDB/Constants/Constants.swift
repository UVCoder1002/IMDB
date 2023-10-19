//
//  Constants.swift
//  IMDB
//
//  Created by Urvashi Gupta on 18/10/23.
//

import Foundation


class Constants {
    
  static let fetchMovieListURLString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page="
    static let moviePosterPathBaseURL : String = "https://image.tmdb.org/t/p/w500"
    static let fetchFilteredListURLString = "https://api.themoviedb.org/3/search/movie?api_key=38a73d59546aa378980a88b645f487fc&include_adult=false&language=en-US&page="
}

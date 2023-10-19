//
//  MovieViewModel.swift
//  IMDB
//
//  Created by Urvashi Gupta on 18/10/23.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var movieList = [Movie]()
    @Published var posterImageList = [Data]()
    var page = 0
     var movieListURLService = URLService(responseHandler: ResponseHandler<Movies>())
  
    func getMovieList(from url: String) {
        
        page+=1
        Task{
            
            await movieListURLService.handleURLRequest(from: url+page.description,parse: true) { movieApiData,error in
                if let error = error {
                
                    print("Error In Fetching GetMovieList \(error.localizedDescription)")
                }
                if let movieApiData = movieApiData as? Movies{
                    DispatchQueue.main.async {
                        self.movieList.append(contentsOf: movieApiData.results)
//                        var movies = [Movie]()
//                        if !self.movieList.isEmpty {
//                            movies.append(contentsOf: self.movieList)
//                        }
//                        movies.append(contentsOf:  movieApiData.results as [Movie])
                       
                
//                    for movie in movies{
//
//                        let posterURL = self.movieListURLService.posterImageURL(from: movie.posterPath )
//                        Task{
//
//                            await self.movieListURLService.handleURLRequest(from: posterURL,parse: false) { data , error in
//                                if let error = error {
//                                    print("Error in fetching image : \(error.localizedDescription)")
//                                }
//                                else{
//                                    //
//                                    movie.posterImage = data as? Data
//                                    DispatchQueue.main.async {
//                                        self.movieList = movies
//                                    }
//
//
//                                    //
//                                }
//
//
//                            }
//                        }
//                    }
                }
    
                }
            }
        }
    }
    
    func handleRefresh(){
        movieList.removeAll()
        getMovieList(from: Constants.fetchMovieListURLString)
    }
}

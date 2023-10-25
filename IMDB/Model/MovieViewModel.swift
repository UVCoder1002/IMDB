//
//  MovieViewModel.swift
//  IMDB
//
//  Created by Urvashi Gupta on 18/10/23.
//

import Foundation


class MovieViewModel: ObservableObject {
    @Published var movieList = [Movie]()
    @Published var filteredList = [Movie]()
    @Published var posterImageList = [Data]()
  
     var movieListURLService = URLService(responseHandler: ResponseHandler<Movies>())
  
    func getMovieList(from url: String,searchQuery: String,page: Int64,isPaginating:Bool) {
        
       
        Task{
            
            await movieListURLService.handleURLRequest(from: url+page.description,searchQuery: searchQuery, parse: true) { movieApiData,error in
                if let error = error {
                
                    print("Error In Fetching GetMovieList \(error.localizedDescription)")
                }
                if let movieApiData = movieApiData as? Movies{
                    DispatchQueue.main.async {
                        if isPaginating{
                            
                            
                            self.movieList.append(contentsOf: movieApiData.results)
                        }
                        else{
                            self.movieList = movieApiData.results
                        }
                        
                }
    
                }
            }
        }
    }
    
   
    
    func handleRefresh(){
        movieList.removeAll()
        getMovieList(from: Constants.fetchMovieListURLString,searchQuery: "",page: 1,isPaginating: false)
    }
}

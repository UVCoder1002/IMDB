//
//  MovieListView.swift
//  IMDB
//
//  Created by Urvashi Gupta on 23/08/23.
//

import SwiftUI

struct MovieListView: View {
    @State private var showMovieDetail = false
    @State private var selectedMovie : Movie?
    @ObservedObject var movieViewModel = MovieViewModel()
    private var movieList : [Movie]{
        return movieViewModel.movieList
    }
    var body: some View {
        NavigationStack{
            ScrollView{
                List {
                    ForEach(movieList){ movie in
                        MovieListRowView(movie : movie)
                            .onAppear(
                                perform: {
                               lastItemAppear(movie)
                                }
                                
                            )
                            .onTapGesture {
                                print("tapped \(showMovieDetail)")
                                selectedMovie = movie
                                showMovieDetail = true

                            }
                    }
                        
                }
                
                .listStyle(PlainListStyle())
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            
        }
        .refreshable {
            movieViewModel.handleRefresh()
        }
        .onAppear(perform: {
            print("DEBUG: IN Perform")
            Task{
                movieViewModel.getMovieList(from:Constants.fetchMovieListURLString)
            }
        })

        .fullScreenCover(isPresented: $showMovieDetail, content: {
            MovieDetailsView(showMovieDetail: $showMovieDetail,selectedMovie: $selectedMovie)
        })
    }
    
}

extension MovieListView{
    private func lastItemAppear(_ movie: Movie){
        if movieList.last?.id == movie.id{
            movieViewModel.getMovieList(from: Constants.fetchMovieListURLString)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

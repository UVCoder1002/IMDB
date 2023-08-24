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
    @State var movieList = [Movie]()
    var body: some View {
        NavigationStack{
            ScrollView{
                
                List(movieList) { movie in
                    MovieListRowView(movie : movie)
                        .onTapGesture {
                            print("tapped \(showMovieDetail)")
                            selectedMovie = movie
                            showMovieDetail = true

                        }
                }
                
                .listStyle(PlainListStyle())
                .frame(height: UIScreen.main.bounds.height - 120)
            }
            
        }
        .onAppear(perform: {
            print("DEBUG: IN Perform")
            Task{
                await URLService.shared.fetchMovieList(from: "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=1"){
                    (movies) in                    Movie.downloadImages(from: movies){(moviesWithImage) in
                        movieList = moviesWithImage
                    }
                    
                }
            }
        })
//        .onChange(of: selectedMovie, perform: { newValue in
//            print("red")
//            showMovieDetail = true
//        })
//        .navigationDestination(isPresented: $showMovieDetail) {
//          MovieDetailsView()
//        }
        .fullScreenCover(isPresented: $showMovieDetail, content: {
            MovieDetailsView(showMovieDetail: $showMovieDetail,selectedMovie: $selectedMovie)
        })
    }
    
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

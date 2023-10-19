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
    @State private var query = ""
    @State private var page = 1
    @StateObject var movieViewModel = MovieViewModel()
    private var movieList : [Movie]{
        return movieViewModel.movieList
    }
    var body: some View {
        NavigationStack{
            ScrollView{
                ListView(showMovieDetail: $showMovieDetail, selectedMovie: $selectedMovie, page: $page, query: query, movieViewModel: movieViewModel)
            }
            
        }
        .navigationTitle("IMDB")
        .searchable(text: $query,prompt: "Find Movie")
        .onChange(of: query, perform: { newValue in
            page = 1
            
            
            movieViewModel.getMovieList(from: Constants.fetchFilteredListURLString, searchQuery: query, page: Int64(page),isPaginating: false)
        })
        .refreshable {
            movieViewModel.handleRefresh()
        }
        .onAppear(perform: {
            print("DEBUG: IN Perform")
            Task{
                movieViewModel.getMovieList(from:Constants.fetchMovieListURLString,searchQuery: query,page: Int64(page),isPaginating: false)
            }
        })

        .fullScreenCover(isPresented: $showMovieDetail, content: {
            MovieDetailsView(showMovieDetail: $showMovieDetail,selectedMovie: $selectedMovie)
        })
    }
    
}

extension ListView{
    private func lastItemAppear(_ movie: Movie){
        if movieList.last?.id == movie.id{
            page+=1
            movieViewModel.getMovieList(from: Constants.fetchMovieListURLString,searchQuery: query,page: Int64(page),isPaginating: true)
        }
    }
}

struct ListView : View{
    @Environment(\.isSearching) var isSearching
    @Binding  var showMovieDetail : Bool
    @Binding var selectedMovie : Movie?
    @Binding  var page : Int
    var query : String
    @ObservedObject var movieViewModel : MovieViewModel
    private var movieList : [Movie]{
        return movieViewModel.movieList
    }
    var body: some View{
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
        .onChange(of: isSearching, perform: { newValue in
            if !newValue{
                page = 1
                movieViewModel.getMovieList(from: Constants.fetchMovieListURLString, searchQuery: query, page: Int64(page),isPaginating: false)
            }
        })
        .listStyle(PlainListStyle())
        .frame(height: UIScreen.main.bounds.height - 120)
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

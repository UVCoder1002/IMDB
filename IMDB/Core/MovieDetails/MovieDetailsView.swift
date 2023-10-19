//
//  MovieDetailsView.swift
//  IMDB
//
//  Created by Urvashi Gupta on 23/08/23.
//

import SwiftUI

struct MovieDetailsView: View {
    @Binding var showMovieDetail : Bool
    @Binding var selectedMovie : Movie?
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack{
            ScrollView{
                Spacer(minLength: 64)
                VStack(alignment: .leading){
                    HStack(spacing: 12){
                        
                   
                        if let poster = selectedMovie?.posterImage{
                            poster
                                .resizable()
                                .scaledToFit()
                                .frame(height: 240)
                                .foregroundColor(Color(.systemGray5))
                                .clipShape(PosterImageHolder())
                        } else{
                            Image(systemName: "photo.artframe")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 160, height: 80)
                                .foregroundColor(Color(.systemGray5))
                        }
                        VStack{
                            VStack(alignment: .leading,spacing: 4){
                                Text("Release Date")
                                    .font(.title3)
                                    .foregroundColor(Color(.systemGray))
                                Text(selectedMovie?.releaseDate.description ?? "" )
                                    .font(.subheadline)
                                    .foregroundColor(Color(.systemGray))
                                
                            }
                            
                            Spacer().frame(height: 32)
                            
                            VStack(alignment: .leading,spacing: 4){
                                Text("⭐️ Rating       ")
                                    .font(.title3)
                                    .foregroundColor(Color(.systemGray))
                                Text((selectedMovie?.voteAverage.description) ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(Color(.systemGray))
                            }
                            Spacer().frame(height: 32)
                            VStack(alignment: .leading,spacing: 4){
                                Text("❤️ Popularity")
                                    .font(.title3)
                                    .foregroundColor(Color(.systemGray))
                                Text(selectedMovie?.popularity.description ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(Color(.systemGray))
                                
                            }
                        }
                    }
                    
                    Spacer(minLength: 64)
                    VStack(alignment: .leading,spacing: 12){
                        Text("Overview")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemGray2))
                        Text(selectedMovie?.overview ?? "In a city where fire, water, land and air residents live together, a fiery young woman and a go-with-the-flow guy will discover something elemental: how much they have in common.")
                            .font(.subheadline)
                            .foregroundColor(Color(.systemGray))
                    }
                    
                }.padding(.horizontal,16)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(selectedMovie?.title ?? "Godzilla Vs Kong")
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        selectedMovie = nil
                        showMovieDetail = false
                        dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "chevron.left" )
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12)
                                .foregroundColor(Color(.systemBlue))
                            
                        }
                    }
                    
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
         
            
            
        }
    }
    
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(showMovieDetail: .constant(true),selectedMovie: .constant(nil) )
    }
}

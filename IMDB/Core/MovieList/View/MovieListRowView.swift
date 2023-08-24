//
//  MovieListRowView.swift
//  IMDB
//
//  Created by Urvashi Gupta on 23/08/23.
//

import SwiftUI

struct MovieListRowView: View {
    var movie : Movie?
   
    var body: some View {
       
        HStack(alignment: .top,spacing: 16){
            if let poster = movie?.posterImage{
                Image(uiImage: UIImage(data: poster)!)                  .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 120)
                    .foregroundColor(Color(.systemGray5))
                    .clipShape(PosterImageHolder())
            } else{
                Image(systemName: "photo.artframe")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                .foregroundColor(Color(.systemGray5))}
            VStack(alignment: .leading, spacing: 8){
                HStack{
                    Text(movie?.title ?? "Godzilla Vs Kong")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.darkGray))
                        .fixedSize(horizontal: false, vertical: true)
                       
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                Text(movie?.overView ?? "In a city where fire, water, land and air residents live together, a fiery young woman and a go-with-the-flow guy will discover something elemental: how much they have in common.")
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundColor(Color(.systemGray3))
            }
            
            
        }
        .frame(height: 100)
        .padding(.vertical,8)
    }
}

struct MovieListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListRowView()
    }
}
//
//  SearchAndFilterBar.swift
//  IMDB
//
//  Created by Urvashi Gupta on 21/10/23.
//

import SwiftUI

struct SearchAndFilterBar: View {
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
            VStack(alignment: .leading){
               Text("Search Movie")
                    .font(.footnote)
                Text("AnyGenre - AnyTime ")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .foregroundStyle(.black)
            }
           
            
        }.padding(.horizontal)
            .padding(.vertical,10)
            .overlay {
                Capsule()
                    .stroke(lineWidth: 0.5)
                    .shadow(color: .black.opacity(0.4),radius: 2)
            }.padding()
    }
}

struct SearchAndFilterBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchAndFilterBar()
    }
}

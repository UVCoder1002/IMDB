//
//  ContentView.swift
//  IMDB
//
//  Created by Urvashi Gupta on 23/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Group{
        
            MovieListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

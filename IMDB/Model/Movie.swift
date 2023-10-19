//
//  Movie.swift
//  IMDB
//
//  Created by Urvashi Gupta on 23/08/23.
//

import Foundation

enum CodingKeys : String,CodingKey{
    case id,posterPath,overview,voteAverage,title,popularity,posterImage,releaseDate
}

class Movie : Identifiable,Codable,ObservableObject{
    
    var id : Int64
    var posterPath : String
    var overview : String
    var voteAverage : Double
    var title : String
    var popularity : Double
    var releaseDate: String
    var posterImage : Data?
    
    
    init(id: Int64,posterPath: String, overview: String, voteAverage: Double, title: String, popularity: Double,releaseDate: String) {
        self.id = id
        self.posterPath = posterPath
        self.overview = overview
        self.voteAverage = voteAverage
        self.title = title
        self.popularity = popularity
        self.releaseDate = releaseDate
    }
    
  
    required init(from decoder: Decoder) throws {
       let values = try decoder.container(keyedBy: CodingKeys.self)
       id = try values.decode(Int64.self, forKey: .id)
       posterPath = try values.decode(String.self, forKey: .posterPath)
        overview = try values.decode(String.self, forKey: .overview)
        voteAverage = try values.decode(Double.self, forKey: .voteAverage)
        title = try values.decode(String.self, forKey: .title)
        popularity = try values.decode(Double.self, forKey: .popularity)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
//        posterImage = try values.decode(Data.self, forKey: .posterImage)
    
     }

    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(id, forKey: .id)
        try values.encode(posterPath, forKey: .posterPath)
        try values.encode(overview, forKey: .overview)
        try values.encode(voteAverage, forKey: .voteAverage)
        try values.encode(title, forKey: .title)
        try values.encode(popularity, forKey: .popularity)
        try values.encode(releaseDate, forKey: .releaseDate)
//        try values.encode(posterImage, forKey: .posterImage)
    }
}


struct Movies: Codable {
    var dates : [String : String]
    var page : Int64
    var totalPages : Int64
    var totalResults : Int64
    var results : [Movie]
}

protocol MovieListable {
    var id : Int64 { get set }
    var title : String? { get set }
    var posterPath : String? { get set }
    var overview : String? { get set}
    var posterImage : Data?  { get set }
}






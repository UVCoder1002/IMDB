//
//  Movie.swift
//  IMDB
//
//  Created by Urvashi Gupta on 23/08/23.
//

import Foundation

enum CodingKeys : CodingKey{
    case id,posterPath,overView,voteAverage,title,popularity,posterImage,releaseDate
}
class Movie : Identifiable,Codable,ObservableObject{
    
    var id : Int64
    var posterPath : String
    var overView : String
    var voteAverage : Double
    var title : String
    var popularity : Double
    var releaseDate: String
    @Published var posterImage : Data?
    
    
    init(id: Int64,posterPath: String, overView: String, voteAverage: Double, title: String, popularity: Double,releaseDate: String) {
        self.id = id
        self.posterPath = posterPath
        self.overView = overView
        self.voteAverage = voteAverage
        self.title = title
        self.popularity = popularity
        self.releaseDate = releaseDate
    }
    
    init(movieDict: NSDictionary){
        self.id = movieDict["id"] as! Int64
        self.posterPath = movieDict["poster_path"] as! String
        self.overView = movieDict["overview"] as! String
        self.voteAverage = movieDict["vote_average"] as! Double
        self.title = movieDict["title"] as! String
        self.popularity = movieDict["popularity"] as! Double
        self.releaseDate = movieDict["release_date"] as! String
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(overView, forKey: .overView)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(title, forKey: .title)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(releaseDate, forKey: .releaseDate)
        
    }
    
   
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.overView = try container.decode(String.self, forKey: .overView)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.title = try container.decode(String.self, forKey: .title)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.posterImage = try container.decodeIfPresent(Data.self, forKey: .posterImage)
        self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
    }
    
    class func downloadImages(from movies: [Movie],completionBlock: @escaping ([Movie]) -> Void) {
        let dispatchGroup = DispatchGroup()
        for movie in movies{
            dispatchGroup.enter()
            let posterURL = URLService.shared.posterImageURL(from: movie.posterPath)
            URLService.shared.downloadImg(InputUrl: posterURL ){ (output) in
                movie.posterImage = output
                dispatchGroup.leave()
            }
            
        }
        dispatchGroup.notify(queue: .main) {
            print(movies[0].posterImage)
            completionBlock(movies)
        }
    }
    
}

struct Movies: Codable {
    var results : [Movie]
}




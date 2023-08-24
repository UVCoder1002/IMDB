//
//  URLService.swift
//  IMDB
//
//  Created by Urvashi Gupta on 23/08/23.
//

import Foundation
import SwiftUI

class URLService{
    
    let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=1"
    
    static var shared  = URLService()
    
    func fetchMovieList(from urlString : String,completionBlock: @escaping ([Movie]) -> Void) async  {
        
         print("func called")
         guard let url = URL(string: urlString) else { return  }
         print("url")
        var request = URLRequest(url: url)
         print("request")
        request.httpMethod = "GET"
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         print(request)

         let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
             print("hii")
           
              
             
//            print("DEBUG: data: \(data)")
            guard let response = response as? HTTPURLResponse else { return }
//            print("DEBUG: response:  \(response)")
            if response.statusCode == 200 {
//                print("DEBUG: response:  \(response)")
                guard let data = data else {return }
                
        
                if let statusesArray = try? JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed) as? [String:Any]{
                    let array = statusesArray["results"] as! [NSDictionary]
                    var movies = [Movie]()
                    for movie in array{
                        let thisMovie = Movie(movieDict: movie)
                        movies.append(thisMovie)
                    }
                    completionBlock(movies)
                }
//                print("DEBUG: data: \(data)")

            }
             
         }
        dataTask.resume()
        
    }
    
    func downloadImg(InputUrl url: String,completionBlock: @escaping (Data) -> Void){
        let imgURL = URL(string: url)!
        URLSession.shared.dataTask(with: imgURL) {
            (data,urlResponse,error) in
            guard error == nil else {
                print("We got an error \(error!.localizedDescription)")
                return
            }
            let response = urlResponse as? HTTPURLResponse
            guard response?.statusCode == 200 else{
                print("The HTTPResponse statusCode is : \(response!.statusCode)")
                return
            }
            guard let imgData = data else{
                return
            }
            completionBlock(imgData)
           
        }.resume()

    }
    func posterImageURL(from url : String) -> String{
        return "https://image.tmdb.org/t/p/w500" + url
    }
}

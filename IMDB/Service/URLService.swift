//
//  URLService.swift
//  IMDB
//
//  Created by Urvashi Gupta on 23/08/23.
//

import Foundation
import SwiftUI

class URLService<T:Decodable>{
        
    var responseHandler = ResponseHandler<T>()
    init(responseHandler: ResponseHandler<T>) {
        self.responseHandler = responseHandler
    }
    
    func handleURLRequest(from urlString : String,parse : Bool,completionBlock: @escaping (Any?,Error?) -> Void) async {
          await NetworkHandler.fetchData(from: urlString) { data, error in
             if let error = error {
             
                 print("Error In Fetching GetMovieList \(error.localizedDescription)")
             }
             if let data = data {
                 if parse{
                     
                     self.responseHandler.parseResponse(data: data) { movies, error in
                         if let error = error {
                             completionBlock(nil,error)
                         }
                         if let movies = movies{
                             completionBlock(movies,nil)
                         }
                     }
                 }
                 else{
                     completionBlock(data,nil)
                 }
             }
             
        }
        
        
    }
    
    
    
    func posterImageURL(from url : String) -> String{
        return Constants.moviePosterPathBaseURL + url
    }
    
//    func fetchMovieList(from urlString : String,completionBlock: @escaping ([Movie]) -> Void) async  {
//
//         print("func called")
//         guard let url = URL(string: urlString) else { return  }
//         print("url")
//        var request = URLRequest(url: url)
//         print("request")
//        request.httpMethod = "GET"
//         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//         print(request)
//
//         let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
//             print("hii")
//
//
//            guard let response = response as? HTTPURLResponse else { return }
//            if response.statusCode == 200 {
//
//                guard let data = data else {return }
//
//
//                if let statusesArray = try? JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed) as? [String:Any]{
//                    let array = statusesArray["results"] as! [NSDictionary]
//                    var movies = [Movie]()
//                    for movie in array{
//                        let thisMovie = Movie(movieDict: movie)
//                        movies.append(thisMovie)
//                    }
//                    completionBlock(movies)
//                }
//
//
//            }
//
//         }
//        dataTask.resume()
//
//    }
    
//    func downloadImg(InputUrl url: String,completionBlock: @escaping (Data) -> Void){
//        let imgURL = URL(string: url)!
//        URLSession.shared.dataTask(with: imgURL) {
//            (data,urlResponse,error) in
//            guard error == nil else {
//                print("We got an error \(error!.localizedDescription)")
//                return
//            }
//            let response = urlResponse as? HTTPURLResponse
//            guard response?.statusCode == 200 else{
//                print("The HTTPResponse statusCode is : \(response!.statusCode)")
//                return
//            }
//            guard let imgData = data else{
//                return
//            }
//            completionBlock(imgData)
//
//        }.resume()
//
//    }
   
}

//HANDLE API CALLS
class NetworkHandler{
    
    
   class func fetchData(from urlString : String,completionBlock: @escaping (Data?,Error?) -> Void) async -> Void  {
        
         print("func called")
         guard let url = URL(string: urlString) else { return   }
         print("DEBUG: url: \(url)")
        var request = URLRequest(url: url)
         print("request")
        request.httpMethod = "GET"
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         print(request)

         let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
             print("hii")
           
              
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {

                guard let data = data else {
                    completionBlock(nil,error)
                    return
                }
               
                completionBlock(data,nil)
    

            }
             else{
                 print("Error : response status: \(response.statusCode)")
             }
          
             
         }
        dataTask.resume()
        
    }
        
}
//PARSE API RESPONSE
class ResponseHandler<T: Decodable> {
    
     func parseResponse(data: Data,completionBlock: @escaping (T?,Error?) -> Void){
        
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
             let userResponse = try decoder.decode(T.self, from: data)
            completionBlock(userResponse,nil)
        }
        catch{
            print("Data: \(data)")
            print("DEBUG: parsing error \(error)")
        }
 
    }
}


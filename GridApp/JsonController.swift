//
//  JsonController.swift
//  GridApp
//
//  Created by Lazaros Fantidis on 14/12/2021.
//

import Foundation

struct RSS: Decodable{
    let feed: Feed
}

struct Feed: Decodable{
    let results: [Result]
}

struct Result:Decodable,Hashable{
    let artistName,name,artworkUrl100,releaseDate: String
}

class GridviewModel: ObservableObject {
    
    @Published var items = 0..<10
    @Published var results = [Result]()
    
    
    init(){
     
            guard let url = URL(string:
                                    "https://rss.applemarketingtools.com/api/v2/us/music/most-played/50/albums.json") else {return}
            URLSession.shared.dataTask(with: url) { (data,resp, err) in
                guard let data = data else {return}
            do {
               let rss = try JSONDecoder().decode(RSS.self , from: data)
                print(rss)
                self.results = rss.feed.results
            } catch {
            print("failure: \(error)")
            }
            }.resume()

            
    }
}

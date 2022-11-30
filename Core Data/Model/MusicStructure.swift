//
//  MusicStructure.swift
//  Core Data
//
//  Created by Cesar Rojas on 11/27/22.
//

import Foundation

struct MusicStructure: Decodable {
    
    let feed: Feed
    
}

struct Feed: Decodable {
    
    let title: String
    let results: [Results]
    
}

struct Results: Decodable {
    
    let artistName: String
    let id: String
    let name: String
    let releaseDate: String
    let kind: String
    let artistId: String
    let artistUrl: String
    let contentAdvisoryRating: String?
    let artworkUrl100: String
    let genres: [Genres]
    let url: String
    
}

struct Genres: Decodable {
    
    let name: String
}

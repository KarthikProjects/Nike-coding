//
//  AlbumResponse.swift
//  Nike-Coding
//
//  Created by karthik  kumar padala on 3/15/20.
//  Copyright © 2020 Nike. All rights reserved.
//

struct AlbumResponse: Codable {
    var feed: Feed?
}

struct Feed: Codable {
    var results: [results]?
}

struct results: Codable {
    var artistName: String?
    var releaseDate: String?
    var name: String?
    var copyright: String?
    var artistUrl: String?
    var artworkUrl100: String?
    var genres: [genres]?
}

struct genres: Codable {
    var name: String?
}

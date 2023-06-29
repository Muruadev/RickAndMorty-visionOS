//
//  EpisodeResponse.swift
//  RickAndMorty
//
//  Created by Fernando Murua Alcazar on 29/6/23.
//

import Foundation

// MARK: - EpisodeResponseElement
struct EpisodeResponseElement: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}

typealias EpisodeResponse = EpisodeResponseElement

//
//  RickAndMortyRepository.swift
//  RickAndMorty
//
//  Created by Fernando Murua Alcazar on 28/6/23.
//

import Foundation
import Alamofire

struct RickAndMortyRepository {
    func fetchCharacters(page: Int) async throws -> CharacterListResponse? {
        guard let url = RickAndMortyEndpoint.characters(page: page).url else {
            return nil
        }
        do {
            let data = try await withUnsafeThrowingContinuation { continuation in
                AF.request(url, method: .get).validate().responseData { response in
                    if let data = response.data {
                        continuation.resume(returning: data)
                        return
                    }
                    if let error = response.error {
                        continuation.resume(throwing: error)
                        return
                    }
                    fatalError("Error while doing Alamofire url request")
                }
            }
            let response = try JSONDecoder().decode(CharacterListResponse.self, from: data)
            return response
        } catch {
            print("---ERROR--- \(error)")
            throw error
        }
    }
    
    func fetchEpisode(id: String) async throws -> EpisodeResponse? {
        guard let url = RickAndMortyEndpoint.episode(id: id).url else {
            return nil
        }
        do {
            let data = try await withUnsafeThrowingContinuation { continuation in
                AF.request(url, method: .get).validate().responseData { response in
                    if let data = response.data {
                        continuation.resume(returning: data)
                        return
                    }
                    if let error = response.error {
                        continuation.resume(throwing: error)
                        return
                    }
                    fatalError("Error while doing Alamofire url request")
                }
            }
            let response = try JSONDecoder().decode(EpisodeResponse.self, from: data)
            return response
        } catch {
            print("---ERROR--- \(error)")
            throw error
        }
    }
}


enum RickAndMortyEndpoint {
    case characters(page: Int)
    case episode(id: String)
    
    var base: String {
        "https://rickandmortyapi.com/api"
    }
    
    var path: String {
        switch self {
        case .characters(let page): return "/character/?page=\(page)"
        case .episode(let id): return "/episode/\(id)"
        }
    }
    
    var url: URL? {
        URL(string: "\(self.base)\(self.path)")
    }
}

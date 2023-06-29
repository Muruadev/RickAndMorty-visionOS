//
//  EpisodeViewModel.swift
//  RickAndMorty
//
//  Created by Fernando Murua Alcazar on 29/6/23.
//

import Foundation


class EpisodeViewModel: ViewModel {
    private let repository: RickAndMortyRepository = .init()
    private let id: String
    
    @Published var data: DataLoading<EpisodeResponseElement> = .idle
    
    var title: String {
        guard case .loaded(let item) = self.data else {
            return "Episode View"
        }
        return item.name
    }
    
    init(id:String) {
        self.id = id
        super.init()
        Task {
            await getEpisode()
        }
    }
    
    @MainActor func getEpisode() async {
        data = .loading
        do {
            let response = try await repository.fetchEpisode(id: id)
            if let response = response {
                data = .loaded(items: response)
            }
        } catch {
            data = .error(message: error.localizedDescription)
        }
    }
}

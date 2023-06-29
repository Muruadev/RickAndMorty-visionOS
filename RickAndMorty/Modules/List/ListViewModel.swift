//
//  ListViewModel.swift
//  RickAndMorty
//
//  Created by Fernando Murua Alcazar on 28/6/23.
//

import Foundation

typealias CharacterList = Result

class ListViewModel: ViewModel {
    
    private let repository = RickAndMortyRepository()
    private var page: Int = 0
    private var items: [CharacterList] = []
    
    @Published var data:  DataLoading<[CharacterList]> = .loading
    @Published var filter: String = "" {
        didSet {
            guard filter.count > 3 else {
                data = .loaded(items: items)
                return
            }
            let itemsFiltered = items.filter ( {$0.name.lowercased().replacingOccurrences(of: " ", with: "").contains(filter.lowercased().replacingOccurrences(of: " ", with: ""))})
            data = .loaded(items: itemsFiltered)
        }
    }
    
    override init () {
        super.init()
        Task{
            await getCharacters()
        }
    }
    
    @MainActor func getCharacters(_ showFullLoading: Bool = true) async {
        guard !loading else { return }
        loading = true
        if showFullLoading {
            data = .loading
        }
        do {
            let response = try await repository.fetchCharacters(page: self.page)
            guard let response = response else {
                loading = false
                return
            }
            items.append(contentsOf: response.results)
            if response.info.next == nil {
                data = .loaded(items: items)
            } else {
                self.changePage()
            }
        } catch {
            print(error)
            data = .error(message: error.localizedDescription)
        }
        loading = false
    }
    
    func changePage() {
        self.page += 1
        Task {
            await getCharacters(false)
        }
    }
    
    func resetList(){
        self.page = 0
        Task {
            await getCharacters(false)
        }
    }
    
    func didTapAnyCharacter(to character: Result) {
        Task {
            await self.navigationController.push(to: .character(item: character))
        }
    }
    
    
}

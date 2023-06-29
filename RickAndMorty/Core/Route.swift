//
//  Route.swift
//  RickAndMorty
//
//  Created by Fernando Murua Alcazar on 29/6/23.
//

import SwiftUI


enum Route {
    case character(item: Result)
    case episode(id: String)
}


// MARK: - Hashable
extension Route: Hashable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.character(let lhsItem), .character(let rhsItem)): return lhsItem.id == rhsItem.id
        case (.episode(let lhsId), .episode(let rhsId)): return lhsId == rhsId
        default: return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}

// MARK: - View

extension Route: View {
    var body: some View {
        switch self {
        case .character(let item): CharacterDetailView(character: item)
        case .episode(let id): EpisodeView(id: id)
        }
    }
}

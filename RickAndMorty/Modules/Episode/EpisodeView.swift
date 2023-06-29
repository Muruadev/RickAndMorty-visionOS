//
//  EpisodeView.swift
//  RickAndMorty
//
//  Created by Fernando Murua Alcazar on 29/6/23.
//

import SwiftUI

struct EpisodeView: View {
    
    @StateObject var viewModel: EpisodeViewModel
    @EnvironmentObject var navigationController: NavigationController

    init(id: String) {
        _viewModel = .init(wrappedValue: .init(id: id))
    }
    
    var body: some View {
        VStack {
            switch viewModel.data {
            case .idle:
                Text("Episode View")
            case .loading:
                Spinner()
            case .loaded(let item):
                Text(item.name)
                    .font(.largeTitle)
                Text(item.airDate)
                    .font(.body)
                HStack {
                    Button("Go back") {
                        navigationController.goBack()
                    }
                    Button("Reset") {
                        navigationController.reset()
                    }
                }
            case .error(let message):
                Text(message)
            }
        }.navigationTitle(viewModel.title)
    }
}

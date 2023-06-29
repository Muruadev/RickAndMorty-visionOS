//
//  ViewModel.swift
//  RickAndMorty
//
//  Created by Fernando Murua Alcazar on 29/6/23.
//

import Foundation


class ViewModel: ObservableObject {
    @Published var navigationController: NavigationController = .shared
    @Published var loading: Bool = false
    
    init() {}
}

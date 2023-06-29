//
//  DataLoading.swift
//  RickAndMorty
//
//  Created by Fernando Murua Alcazar on 28/6/23.
//

import Foundation

enum DataLoading<T> {
    case idle
    case loading
    case loaded(items: T)
    case error(message: String)
}

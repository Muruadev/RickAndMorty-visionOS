//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by Fernando Murua Alcazar on 29/6/23.
//

import XCTest
@testable import RickAndMorty
final class RickAndMortyTests: XCTestCase {

    var viewModel: ListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = .init()
    }
    
    
    func testViewModelGetData() async throws {
        await viewModel.getCharacters()
        if case .error = viewModel.data {
            XCTFail("Error")
        }
    }

}

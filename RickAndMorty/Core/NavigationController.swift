//
//  NavigationController.swift
//  RickAndMorty
//
//  Created by Fernando Murua Alcazar on 29/6/23.
//
import SwiftUI

class NavigationController: ObservableObject {
    
    static var shared: NavigationController = {
        let instance = NavigationController()
        return instance
    } ()
    
    private init() {}
    
    @Published var routes = [Route]()
    
    @MainActor func push(to route: Route) {
        routes.append(route)
    }
    
    @MainActor func goBack() {
        guard routes.count > 1 else { return }
        routes.removeLast()
     }
    
    @MainActor func reset() {
        routes = []
    }
    
    @MainActor func goTo(to route: Route) {
        guard let index = routes.firstIndex(where: {$0 == route} ) else { return }
        routes = Array(routes[0...index])
    }
}

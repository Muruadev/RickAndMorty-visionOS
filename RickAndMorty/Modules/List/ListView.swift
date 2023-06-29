//
//  ListView.swift
//  RickAndMorty
//
//  Created by Fernando Murua Alcazar on 28/6/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel = .init()
    @ObservedObject var navigationController = NavigationController.shared
    
    let spaceName = "scroll"
    
    @State var copiedDone: Bool = false
    
    var body: some View {
        NavigationStack(path: $navigationController.routes) {
            VStack {
                TextField("Filter", text: $viewModel.filter)
                    .padding()
                    .border(Color.white)
                    .clipShape(.rect(cornerRadii: .init()))
                    .padding(.horizontal)
                    .submitLabel(.search)
                switch viewModel.data {
                case .idle:
                    Text("Characters List")
                case .loading:
                    Spinner()
                        .padding()
                case .loaded(let items):
                        ScrollView {
                                VStack{
                                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                                        ForEach(items) { item in
                                            VStack {
                                                CharacterView(character: item)
                                                    .contextMenu {
                                                        NavigationLink(value: Route.character(item: item)) {
                                                            Text("See detail")
                                                        }
                                                        Button("Copy") {
                                                            UIPasteboard.general.setValue(item.name, forPasteboardType: UTType.plainText.identifier)
                                                            copiedDone.toggle()
                                                        }
                                                    }

                                                NavigationLink(value: Route.character(item: item)) {
                                                    Text("See detail")
                                                }
                                            }
                                        }
                                    }
                                }
                        }.refreshable {
                            
                        }
                case .loaded(let items) where items.isEmpty:
                    Text("No data")
                case .error(let message):
                    Text(message)
                }
            }
            .sheet(isPresented: $copiedDone, content: {
                Text("Name copied!")
                    .presentationDetents([.large])
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.copiedDone.toggle()
                        }
                    }
            })
            .navigationTitle("Rick & Morty App")
            .navigationDestination(for: Route.self, destination: {
                $0.environmentObject(navigationController)
            })
        }
        
    }
}

struct ViewOffsetKey: PreferenceKey {
  typealias Value = CGFloat
  static var defaultValue = CGFloat.zero
  static func reduce(value: inout Value, nextValue: () -> Value) {
    value += nextValue()
  }
}

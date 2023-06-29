//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Fernando Murua Alcazar on 29/6/23.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Result
    
    @State var image: UIImage?
    
    var body: some View {
            VStack {
                if let image {
                    VStack {
                        Image(uiImage: image)
                            .resizable()
                            .frame(maxWidth: 200, maxHeight: 200)
                            .aspectRatio(image.size,contentMode: .fill)
                    }
                        
                } else {
                    Skeleton()
                        .frame(maxWidth: 200, maxHeight: 200)
                }
                Divider()
                    .frame(height: 20)
                List {
                    Section("Data") {
                        LabeledContent {
                            Text(character.name)
                                .font(.title2)
                        } label: {
                            Text("Name")
                                .font(.title2)
                        }
                        LabeledContent {
                            Text(character.gender)
                                .font(.title2)
                        } label: {
                            Text("Gender")
                                .font(.title2)
                        }
                        LabeledContent {
                            Text(character.status)
                                .font(.title2)
                        } label: {
                            Text("Status")
                                .font(.title2)
                        }
                        LabeledContent {
                            Text(character.location.name)
                                .font(.title2)
                        } label: {
                            Text("Location")
                                .font(.title2)
                        }
                        LabeledContent {
                            Text(character.species)
                                .font(.title2)
                        } label: {
                            Text("Species")
                                .font(.title2)
                        }
                    }.headerProminence(.increased)
                    
                    Section("Episodes") {
                        ForEach(character.episode.indices) { index in
                            if let episode = character.episode[index].last {
                                NavigationLink(value: Route.episode(id: String(episode))) {
                                    Text("Episode \(String(episode))")
                                }
                            } else {
                                Text("Failed to parse episode")
                            }
                        }
                    }.headerProminence(.increased)
                }
            }
            .padding(.bottom)
        
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            loadImageFromURL()
        }
    }
    
    private func loadImageFromURL() {
        guard let url = URL(string: character.image) else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let loadedImage = UIImage(data: data) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        
                        self.image = loadedImage
                    }
                }
            }.resume()
        }
}

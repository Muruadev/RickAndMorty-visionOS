//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Fernando Murua Alcazar on 28/6/23.
//

import SwiftUI

struct CharacterView: View {
    let character : Result
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        LazyVStack {
            VStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Skeleton()
                }
                
            }.frame(width: 300, height: 300)
            Text(character.name)
                .font(.largeTitle)
                .foregroundStyle(Color.white)
            Text(character.gender)
                .font(.body)
                .foregroundStyle(Color.white)
        }
        .onAppear {
            loadImageFromURL()
        }
    }
    
    private func loadImageFromURL() {
        guard let url = URL(string: character.image) else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let loadedImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = loadedImage
                    }
                }
            }.resume()
        }
}


struct Skeleton: View {
    @State var isShimmering: Bool = false
    
    var body: some View {
            Rectangle()
                .foregroundStyle(.linearGradient(colors: [
                    .gray,
                    .gray.opacity(0.2)
                ], startPoint: .leading, endPoint: isShimmering ? .trailing : .leading))
                .redacted(reason: .placeholder)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: false), value: isShimmering)
                .onAppear{
                    isShimmering.toggle()
                }
    }
}

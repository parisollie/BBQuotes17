//
//  EpisodeView.swift
//  BBQuotes17
//
//  Created by Paul F on 06/11/24.
//

import SwiftUI
//paso 4.12
struct EpisodeView: View {
    let episode: Episode
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text(episode.title)
                .font(.largeTitle)
            
            Text(episode.seasonEpisode)
                .font(.title2)
            
            AsyncImage(url:episode.image){image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 15))
                
            }placeholder: {
                ProgressView()
            }
            
            Text(episode.synopsis)
                .font(.title3)
                .minimumScaleFactor(0.5)
                .padding(.bottom)
            Text("Written by: \(episode.writtenBy)")
            Text("Directed by: \(episode.directedBy)")
            Text("Aired: \(episode.airDate)")
        }
        .padding()
        .foregroundStyle(.white)
        .background(.black.opacity(0.6))
        .clipShape(.rect(cornerRadius: 25))
        .padding(.horizontal)
    }
}

#Preview {
    EpisodeView(episode: ViewModel().episode)
}

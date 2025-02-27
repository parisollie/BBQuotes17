//
//  Episode.swift
//  BBQuotes17
//
//  Created by Paul F on 06/11/24.
//

import Foundation

//Vid 64, Paso 83 Episode Model

struct Episode : Decodable{
    
    let episode: Int //101 -> temporada 1 episodio 01
    let title: String
    let image: URL
    let synopsis: String
    let writtenBy: String
    let directedBy: String
    let airDate: String
    
    //computer property
    var seasonEpisode: String{
        var episodeString = String(episode)// "101", season episode 1
        let season = episodeString.removeFirst()//episodeString: "01", season "1",removemos el 0
        
        if episodeString.first! == "0"{
            episodeString = String(episodeString.removeLast()) // "1"
        }
        //Regresa Season y la propiedad (season)
        return "Season \(season), Episode \(episodeString)"
    }
}

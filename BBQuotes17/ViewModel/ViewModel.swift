//
//  ViewModel.swift
//  BBQuotes17
//
//  Created by Paul F on 05/11/24.
//

import Foundation

//paso 1.19
@Observable
class ViewModel {
    enum FetchStatus{
        //Tendremos 4 casos
        case notStarted
        case fetching
        //Paso 4.10,
        case successQuote
        case successEpisode
        case failed(error: Error)
    }
    
    //Paso 1.20,otros pueden acceder a la variable,pero no cambiarla private(set)
    private(set) var status: FetchStatus = .notStarted
    //Inicializamos, Ya podemos usar nuestros FetchService que creamos
    private let fetcher = FetchService()
    
    //fetcher.
    
    //Paso 1.21, accedemos a las variables del FetchService
    var quote: Quote
    var character: Character
    //paso 4.?
    var episode: Episode
    
    //V-54,Paso 1.22,corre automaticamente en cuanto se inicialice en nuestro ViewModel
    init(){
        //Paso 1.23
        let decoder = JSONDecoder()
        //usamos esto porque al menos tenemos con 2 propiedades
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let quoteData = try! Data(contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
        quote = try! decoder.decode(Quote.self, from: quoteData)
        
        let characterData = try! Data(contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
        character = try! decoder.decode(Character.self, from: characterData)
        
        let episodeData = try! Data(contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!)
        episode = try! decoder.decode(Episode.self, from: episodeData)
    }
    
    //V-56,paso 2.0, es para saber las últimas palabras cuando murio el personaje
    func getQuoteData(for show: String) async {
        do {
            quote = try await fetcher.fetchQuote(from: show)
            character = try await fetcher.fetchCharacter(quote.character)
            character.death = try await fetcher.fetchDeath(for: character.name)
            status = .successQuote
        }catch {
            status = .failed(error: error)
        }
    }
    
    //Paso 4.?
    
    func getEpisode(for show: String)async{
        status = .fetching
        
        do{
            if let unwrappedEpisode = try await fetcher.fetchEpisode(from: show){
                
                episode = unwrappedEpisode
                status = .successEpisode
                
            }
        }catch{
            status = .failed(error: error)
        }
    }
}

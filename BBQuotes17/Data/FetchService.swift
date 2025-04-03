//
//  FetchService.swift
//  BBQuotes17
//
//  Created by Paul F on 05/11/24.
//

import Foundation

//paso 1.8
struct FetchService {
    //Paso 1.9, ponemos el bad response por si no recibimos una respuesta
    //Lo cambiamos a privado
    private enum FetchError: Error {
        case badResponse
    }
    //Paso 1.10,le ponemos (!)
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    //https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    //IMPORTANTE
    //Paso 1.11, le ponemos el async y con throws , podemos tener error y Quote es lo que queremos.
    func fetchQuote(from show: String) async throws -> Quote {
        
        //Paso 1.12, Build fetch url, el appending le pone el (/)por nosotros
       
        let quoteURL = baseURL.appending(path: "quotes/random")
        //Paso 1.13,No nos preocumos por el (+) porque la funcion de queryitems lo hace por nosotros
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        //Vid 51,paso 1.14 - Fetch data
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        //Vid 52,Paso 1.15, Handle response, si fue una buena respuesta
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            //sino fue una respuesta le mandamos un error
            throw FetchError.badResponse
        }
        
        // paso 1.16, Decode data, decodificamos los datos
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // Return quote
        
        return quote
    }
    /*------------------------------------------------------------------------------------------------*/
    
    //Repetimos los mismos pasos que arriba
    //https://breaking-bad-api-six.vercel.app/api/characters?name=Walter+White
    
    //V-52, paso 1.17
    func fetchCharacter(_ name: String ) async throws -> Character {
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        //es diferente porque es una coleccion de carcateres
        let characters = try decoder.decode([Character].self, from: data)
        //regresamos el primero que encuentre
        return characters[0]
    }
    
    /*------------------------------------------------------------------------------------------------*/
    
    //Paso 1.18
    //https://breaking-bad-api-six.vercel.app/api/deaths
    func fetchDeath(for character:String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
    
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.character == character {
                return death
            }
        }
        //debe regresar algo ,por eso le ponemos nil sino encuentra los muertos
        return nil
    }
    /*------------------------------------------------------------------------------------------------*/
    
    //Vid 65,paso 4.9
    //Episode? ,le pones el (?) por si no viene nada
    func fetchEpisode(from show: String ) async throws -> Episode? {
        let episodeURL = baseURL.appending(path: "episodes")
        let fetchURL = episodeURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let episodes = try decoder.decode([Episode].self, from: data)
        
        return episodes.randomElement()
    }
}

        
        

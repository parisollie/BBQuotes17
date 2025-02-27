//
//  FetchService.swift
//  BBQuotes17
//
//  Created by Paul F on 05/11/24.
//

import Foundation

//Vid 51, paso 9
struct FetchService {
    //Paso 10, ponemos el bad response por si no recibimos una respuesta
    //Lo cambiamos a privado
    private enum FetchError: Error {
        case badResponse
    }
    //Paso 11,le ponemos (!)
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    //https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    //IMPORTANTE
    //Paso 12, le ponemos el async y con throws , podemos tener error y Quote es lo que queremos.
    func fetchQuote(from show: String) async throws -> Quote {
        
        //Paso 13, Build fetch url, el appending le pone el (/)po nosotros
        
        let quoteURL = baseURL.appending(path: "quotes/random")
        //Paso 15,No nos preocumos por el (+) porque la funcion de queryitems lo hace por nosotros
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        //Vid 51,paso 16- Fetch data
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        //Vid 52,Paso 17, Handle response, si fue una buena respuesta
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            //sino fue una respuesta le mandamos un error
            throw FetchError.badResponse
        }
        
        // paso 18, Decode data, decodificamos los datos
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // Return quote
        
        return quote
    }
    /*------------------------------------------------------------------------------------------------*/
    
    //Repetimos los mismos pasos que arriba
    //https://breaking-bad-api-six.vercel.app/api/characters?name=Walter+White
    
    //Vid 52, paso 19
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
    
    //Paso 20
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
    
    //Vid 65,paso 84
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

        
        

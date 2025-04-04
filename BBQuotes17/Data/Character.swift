//
//  Character.swift
//  BBQuotes17
//
//  Created by Paul F on 05/11/24.
//

import Foundation

//Paso 1.5,decodable por el JSON, deben ser iguales a las propiedades que tenemos en el archivo "samplecharacter".
struct Character : Decodable {
    
    let name : String
    let birthday: String
    //Occupations es una colección de strings [String].
    let occupations: [String]
    let images: [URL]
    let aliases : [String]
    let status: String
    let portrayedBy: String
    //V-50,paso 1.7,Le ponemos var ,porque puede morir después ,así que es cambiable y le ponemos un opcional(?)
    var death: Death?
    
    //Vid 89
    enum CodingKeys: CodingKey {
        case name
        case birthday
        case occupations
        case images
        case aliases
        case status
        case portrayedBy
    }
    //Paso 1.24
    init(from decoder: any Decoder) throws {
        //Este código se hace automáticamente
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        birthday = try container.decode(String.self, forKey: .birthday)
        occupations = try container.decode([String].self, forKey: .occupations)
        images = try container.decode([URL].self, forKey: .images)
        aliases = try container.decode([String].self, forKey: .aliases)
        status = try container.decode(String.self, forKey: .status)
        portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
        
        //Paso 1.25,para death cambia ,necesitamos un JSONDecoder
        let deathDecoder = JSONDecoder()
        deathDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let deathData = try! Data(contentsOf: Bundle.main.url(forResource: "sampledeath", withExtension: "json")!)
        death = try! deathDecoder.decode(Death.self, from: deathData)
        
    }
}



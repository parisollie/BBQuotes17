//
//  Death.swift
//  BBQuotes17
//
//  Created by Paul F on 05/11/24.
//

import Foundation

//Paso 1.6,decodable por el JSON, deben ser iguales a las propiedades que tenemos en el archivo "sampledeath".
struct Death: Decodable {
    
    let character: String
    let image: URL
    let details: String
    let lastWords: String
    
}

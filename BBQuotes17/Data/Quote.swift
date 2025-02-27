//
//  Quote.swift
//  BBQuotes17
//
//  Created by Paul F on 05/11/24.
//

import Foundation

/*Vid 49,paso 5,decodable por el JSON, deben ser iguales a las propiedades que tenemos en el archivo
"samplequote"*/

struct Quote: Decodable {
    
    let quote: String
    let character: String
}

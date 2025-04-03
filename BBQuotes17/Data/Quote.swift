//
//  Quote.swift
//  BBQuotes17
//
//  Created by Paul F on 05/11/24.
//

import Foundation

/*V-49,paso 1.4 decodable por el JSON, deben ser iguales a las propiedades que tenemos en el archivo
"samplequote"*/

struct Quote: Decodable {
    //Necesitamos el quote y character nada más por nuestra pantalla
    let quote: String
    let character: String
}

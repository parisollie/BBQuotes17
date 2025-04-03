//
//  StringExt.swift
//  BBQuotes17
//
//  Created by Paul F on 06/11/24.
//

import Foundation

//Vid 63,paso 4.2

extension String {
    
    func removeSpaces() -> String {
        //Si tiene una línea por defecto no es necesario poner el return.
        self.replacingOccurrences(of: " ", with: "")
    }
    //Paso 4.3
    func removeCaseAndSpace() -> String {
        self.removeSpaces().lowercased()
    }
}

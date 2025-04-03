//
//  ContentView.swift
//  BBQuotes17
//
//  Created by Paul F on 05/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //Paso 1, V-48, creamos el TabView
        TabView {
            FetchView(show: Constants.bbName)
                //Paso 3,Con este modifier aparece la línea de abajo de los tabs,para que se puedan distinguir.
                .toolbarBackground(.visible, for: .tabBar)
                 //Paso 2,ponemos el .tabItem, y ponemos las imágenes.
                .tabItem{
                    Label(Constants.bbName, systemImage: "tortoise")
                }
            FetchView(show: Constants.bcsName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem{
                    Label(Constants.bcsName, systemImage: "briefcase")
                }
            //V-71, paso 70, add el camino
            FetchView(show: Constants.ecName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem{
                    Label(Constants.ecName, systemImage: "car")
                }
        }
        //Paso 4,ponemos el darkmode
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

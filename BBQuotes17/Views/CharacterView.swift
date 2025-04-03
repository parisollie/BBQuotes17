//
//  CharacterView.swift
//  BBQuotes17
//
//  Created by Paul F on 06/11/24.
//

import SwiftUI

struct CharacterView: View {
    //Vid 58, paso 48
    let character : Character
    let show: String
    
    var body: some View {
        //Paso 50 ,ponemos GeometryReader{ geo in
        GeometryReader{ geo in
            //Vid 62,paso 74, ponemos el ScrollViewReader
            ScrollViewReader { proxy in
                //Paso 51 ,ponemos el Zstack
                ZStack(alignment: .top){
                    //lo mandamos a llamar de stringExt,.removeCaseAndSpace()
                    //Paso 52 ponemos el.removeSpaces()
                    //Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    //Paso 81, add  show.removeCaseAndSpace()
                    Image(show.removeCaseAndSpace())
                        .resizable()
                        .scaledToFit()
                    //Paso 53, add the scrolliew
                    ScrollView{
                        //Vid 61,Paso 71 add a Tabview
                        TabView {
                            //Paso 72 add el For each para obtener todas las iamgenes (las bolitas blancas)
                            ForEach(character.images, id: \.self){
                                characterImageURL in
                                //Paso 54, ponemos el AsyncImage
                                //Paso 73, obtenemos todas las imágenes url: characterImageURL
                                AsyncImage(url: characterImageURL){image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                }placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        //Paso 72,.page para multiples imagenes,repetido
                        .tabViewStyle(.page)
                        //Paso 55
                        .frame(width: geo.size.width/1.2,height: geo.size.height/1.7)
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.top,60)
                        
                        //Paso 56, add VStack
                        VStack(alignment: .leading){
                            //Paso 57,ponemos las caracteristicas del personaje
                            Text(character.name)
                                .font(.largeTitle)
                            Text("Portrayed By: \(character.portrayedBy)")
                                .font(.subheadline)
                            //El divider nos pone la línea
                            Divider()
                            /*---------------------------------------------*/
                            
                            Text("\(character.name) Character info")
                                .font(.title2)
                            /*---------------------------------------------*/
                            Divider()
                            Text("Born: \(character.birthday)")
                            Text("Ocupations:")
                            //Vid 58,Paso 58, hacemos un for each para que nos traiga las ocupaciones
                            ForEach(character.occupations,id: \.self){occupation in
                                Text("•\(occupation)")
                                    .font(.subheadline)
                            }
                            /*---------------------------------------------*/
                            Divider()
                            
                            Text("Nicknames:")
                            //Paso 59,algunos personajes no tienen nicknames, si hay algo en la lista mayor a cero.
                            if character.aliases.count > 0 {
                                ForEach(character.aliases,id: \.self){alias in
                                    Text("•\(alias)")
                                        .font(.subheadline)
                                }
                            }else{
                                Text("None")
                                    .font(.subheadline)
                            }
                            /*---------------------------------------------*/
                            Divider()
                            
                            //Vid 59, paso 62,nos mostrará una flecha ->
                            DisclosureGroup("Status (spoiler alert)"){
                                //Paso 66,ponemos un VSTack para alinearlo,paso 65 no existe
                                VStack(alignment:.leading){
                                    //Paso 64,
                                    Text(character.status)
                                        .font(.title2)
                                    //Paso 67, si el caracter esta muerto mostramos esto.
                                    if let death = character.death{
                                        //Paso 68,mostramos la imagen del personaje
                                        AsyncImage(url: death.image){image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .clipShape(.rect(cornerRadius: 15))
                                                //Paso 76,
                                                .onAppear{
                                                    withAnimation{
                                                        //1 es el id one que es el VStack
                                                        proxy.scrollTo(1,anchor: .bottom)
                                                    }
                                                }
                                        }placeholder: {
                                            ProgressView()
                                        }
                                        //Paso 69
                                        Text("How: \(death.details)")
                                            .padding(.bottom,7)
                                        Text("Last words: \"\(death.lastWords)\"")
                                    }
                                }
                                //Paso 67,repetido
                                .frame(maxWidth: .infinity,alignment: .leading)
                            }
                            //Paso 68, con esto cambiamos el tint de azúl a negro,repetido
                            //.tint(.primary)
                        }
                        //Paso 57,repetido
                        .frame(width: geo.size.width/1.25,alignment: .leading)
                        //Vid 59,Paso 63, agregamos padding ⬆️,para que se vaya hacia arriba.
                        .padding(.bottom,50)
                        //Paso 75, ponemos el id is  a non child view por el id
                        .id(1)
                    }
                    //Paso 59,repetido
                    .scrollIndicators(.hidden)
                }
            }
        }
        //Paso 51, add .ignoresSafeArea(),paso 51, repetido
        .ignoresSafeArea()
    }
}

#Preview {
    //Paso 49
    CharacterView(character: ViewModel().character, show: Constants.bbName)
}

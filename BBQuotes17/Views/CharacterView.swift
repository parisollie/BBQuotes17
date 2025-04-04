//
//  CharacterView.swift
//  BBQuotes17
//
//  Created by Paul F on 06/11/24.
//

import SwiftUI

struct CharacterView: View {
    //V-60,paso 2.18
    let character : Character
    let show: String
    
    var body: some View {
        //Paso 2.20 ,ponemos GeometryReader{ geo in
        GeometryReader{ geo in
            //V-64,paso 3.19, ponemos el ScrollViewReader
            ScrollViewReader { proxy in
                //Paso 2.21 ,ponemos el Zstack
                ZStack(alignment: .top){
                    //lo mandamos a llamar de stringExt,.removeCaseAndSpace()
                    //Paso 2.23 ponemos el.removeSpaces()
                    //Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    //Paso 4.6, add  show.removeCaseAndSpace()
                    Image(show.removeCaseAndSpace())
                        .resizable()
                        .scaledToFit()
                    //Paso 2.24, add the scrolliew
                    ScrollView{
                        //Paso 3.16 add a Tabview
                        TabView {
                            //Paso 3.18 add el For each para obtener todas las iamgenes (las bolitas blancas)
                            ForEach(character.images, id: \.self){
                                characterImageURL in
                                //Paso 2.25, ponemos el AsyncImage
                                //obtenemos todas las imágenes url: characterImageURL
                                AsyncImage(url: characterImageURL){image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                }placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        //Paso 3.17,.page para multiples imagenes,repetido
                        .tabViewStyle(.page)
                        //Paso 3.0
                        .frame(width: geo.size.width/1.2,height: geo.size.height/1.7)
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.top,60)
                        
                        //Paso 3.1, add VStack
                        VStack(alignment: .leading){
                            //Paso 3.2,ponemos las características del personaje
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
                            //Paso 3.4, hacemos un for each para que nos traiga las ocupaciones
                            ForEach(character.occupations,id: \.self){occupation in
                                Text("•\(occupation)")
                                    .font(.subheadline)
                            }
                            /*---------------------------------------------*/
                            Divider()
                            
                            Text("Nicknames:")
                            //Paso 3.5,algunos personajes no tienen nicknames, si hay algo en la lista mayor a cero.
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
                            
                            //V-61,paso 3.9,nos mostrará una flecha ->
                            DisclosureGroup("Status (spoiler alert)"){
                                //Paso 3.10,ponemos un VSTack para alinearlo.
                                VStack(alignment:.leading){
                                    //Paso 3.11
                                    Text(character.status)
                                        .font(.title2)
                                    //Paso 3.12, si el caracter esta muerto mostramos esto.
                                    if let death = character.death{
                                        //Paso 3.13,mostramos la imagen del personaje
                                        AsyncImage(url: death.image){image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .clipShape(.rect(cornerRadius: 15))
                                                //Paso 4.1,
                                                .onAppear{
                                                    withAnimation{
                                                        //1 es el id one que es el VStack
                                                        proxy.scrollTo(1,anchor: .bottom)
                                                    }
                                                }
                                        }placeholder: {
                                            ProgressView()
                                        }
                                        //Paso 3.14
                                        Text("How: \(death.details)")
                                            .padding(.bottom,7)
                                        Text("Last words: \"\(death.lastWords)\"")
                                    }
                                }
                                //Paso
                                .frame(maxWidth: .infinity,alignment: .leading)
                            }
                            //Paso , con esto cambiamos el tint de azúl a negro,repetido
                            //.tint(.primary)
                        }
                        //Paso 3.3
                        .frame(width: geo.size.width/1.25,alignment: .leading)
                        //Paso 3.10, agregamos padding ⬆️,para que se vaya hacia arriba.
                        .padding(.bottom,50)
                        //Paso 4.0, ponemos el id is  a non child view por el id
                        .id(1)
                    }
                    //Paso 3.6
                    .scrollIndicators(.hidden)
                }
            }
        }
        //Paso 2.22, add .ignoresSafeArea()
        .ignoresSafeArea()
    }
}

#Preview {
    //Paso 2.19
    CharacterView(character: ViewModel().character, show: Constants.bbName)
}

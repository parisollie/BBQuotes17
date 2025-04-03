//
//  QuoteView.swift
//  BBQuotes17
//
//  Created by Paul F on 05/11/24.
//

import SwiftUI

struct FetchView: View {
    //Properties
    
    //Vid 55,paso 2.1
    let vm = ViewModel()
    //Para saber que show veremos ,tenemos 3
    let show: String
    //Paso 3.7
    @State var showCharacterInfo = false
    
    var body: some View {
        //Paso 2.2 usamos el GeometryReader{geo in
        GeometryReader{geo in
            ZStack{
                //Paso 2.3,imágen,lo mandamos a llamar de "StringExt",.removeCaseAndSpace()
                //Paso 4.4, add  show.removeCaseAndSpace()
                Image(show.removeCaseAndSpace())
                    //Paso 33
                    .resizable()
                    .frame(width: geo.size.width * 2.7,height: geo.size.height * 1.2)
                VStack{
                    //Vid 72,Ponemos otra VS,para que el botón no se mueva
                    //Paso 2.16, add another VStack,para mantener los botones siempre abajo
                    VStack{
                        //Paso 2.12, agregamos un spacer
                        Spacer(minLength: 60)
                        //Paso 2.15, ponemos el switch con 4 casos
                        switch vm.status {
                            
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .successQuote:
                            //Paso 2.5
                            Text("\"\(vm.quote.quote)\"")
                                 //hacemos el texto mas pequeño con este modifer
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            //Paso 2.7, para que aparezca desde el fondo
                            ZStack(alignment: .bottom){
                                //Las imágenes son una colección de URL
                                AsyncImage(url: vm.character.images[0]){image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                }placeholder: {
                                    //lo ponemos en lo que llega la imágen.
                                    ProgressView()
                                }
                                //Paso 2.8,para que el texto no se vaya atrás
                                .frame(width: geo.size.width/1.1,height: geo.size.height/1.8)
                                //Para el nombre del perosnaje
                                Text(vm.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                
                            }
                            .frame(width: geo.size.width/1.1,height: geo.size.height/1.8)
                            .clipShape(.rect(cornerRadius:50))
                            //Vid 58,paso 3.8
                            .onTapGesture {
                                showCharacterInfo.toggle()
                            }
                            
                            //Vid 81
                            
                        case .successEpisode:
                            EpisodeView(episode: vm.episode)
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }
                        
                        Spacer (minLength: 20)
                    }
                    //Vid 81, oponemos un Hstack
                    HStack{
                        //VID 71
                        Button{
                            //V-57, paso 2.14,ponemos Task para no causar problemas con el await.
                            Task{
                                await vm.getQuoteData(for: show)
                            }
                        }label:{
                            //V-56,paso 2.9
                            Text("Get Random Quote")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                //lo mandamos a llamar de "StringExt".removeCaseAndSpace()
                                //color paso 2.10
                                //Paso 2.17,ponemos el color del show,(Color("\(show.removeSpaces())Button")
                                //Paso 4.5, add  show.removeCaseAndSpace()
                                //Nuestro color se llama "BreakingBadButton"
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color:Color("\(show.replacingOccurrences(of: " ", with: ""))Button"),radius: 7)
                        }
                        //Paso 2.11, ponemos el spacer
                        Spacer()
                        
                        /*+++++++++++++++++++ SEGUNDO BOTON +++++++++++++++++++**/
                        //VID 66,PASO 4.14
                        Button{
                            Task{
                                await vm.getEpisode(for: show)
                            }
                            
                        }label:{
                            Text("Get Random Episode")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                            //lo mandamos a llamar de string Ext,.removeCaseAndSpace()
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color:Color("\(show.replacingOccurrences(of: " ", with: ""))Button"),radius: 7)
                        }
                    }
                    .padding(.horizontal,30)
                    //Paso 2.13, agregamos un spacer
                    Spacer(minLength: 95)
                }
                //Paso 2.6
                .frame(width: geo.size.width,height: geo.size.height)
            }
            //Paso 34, centramos la imagen del background con el geometry
            .frame(width: geo.size.width,height: geo.size.height)
        }
        //Paso 2.4,para que ignore el safarea
        .ignoresSafeArea()
        //Paso 3.10, enseñamos el personaje con el sheet.,repetido
        .sheet(isPresented: $showCharacterInfo){
            CharacterView(character: vm.character, show: show)
        }
    }
}

#Preview {
    //con esto estamos cambiando el color, por el show
    FetchView(show: Constants.bbName)
        .preferredColorScheme(.dark)
}

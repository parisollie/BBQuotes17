//
//  QuoteView.swift
//  BBQuotes17
//
//  Created by Paul F on 05/11/24.
//

import SwiftUI

struct FetchView: View {
    //Properties
    
    //Vid 55,paso 29
    let vm = ViewModel()
    //Para saber que show veremos ,tenemos 3
    let show: String
    //Paso 60
    @State var showCharacterInfo = false
    
    var body: some View {
        //Paso 30 usamos el GeometryReader{geo in
        GeometryReader{geo in
            ZStack{
                //Paso 31,imágen,lo mandamos a llamar de "StringExt",.removeCaseAndSpace()
                //Paso 79, add  show.removeCaseAndSpace()
                Image(show.removeCaseAndSpace())
                    //Paso 33
                    .resizable()
                    .frame(width: geo.size.width * 2.7,height: geo.size.height * 1.2)
                VStack{
                    //Vid 72,Ponemos otra VS,para que el botón no se mueva
                    //Paso 46, add another VStack,para mantener los botones siempre abajo
                    VStack{
                        //Paso 42, agregamos un spacer
                        Spacer(minLength: 60)
                        //Paso 45, ponemos el switch con 4 casos
                        switch vm.status {
                            
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .successQuote:
                            //Paso 35
                            Text("\"\(vm.quote.quote)\"")
                                 //hacemos el texto mas pequeño con este modifer
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            //Paso 37, para que aparezca desde el fondo
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
                                //Paso 38,para que el texto no se vaya atrás
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
                            //Vid 58,paso 61
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
                            //Vid 57, paso 44,ponemos Task para no causar problemas con el await.
                            Task{
                                await vm.getQuoteData(for: show)
                            }
                        }label:{
                            //Vid 56,paso 39
                            Text("Get Random Quote")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                //lo mandamos a llamar de "StringExt".removeCaseAndSpace()
                                //color paso 40
                                //Paso 47,ponemos el color del show,(Color("\(show.removeSpaces())Button")
                                //Paso 80, add  show.removeCaseAndSpace()
                                //Nuestro color se llama "BreakingBadButton"
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 7))
                                .shadow(color:Color("\(show.replacingOccurrences(of: " ", with: ""))Button"),radius: 7)
                        }
                        //Paso 41, ponemos el spacer
                        Spacer()
                        
                        /*+++++++++++++++++++ SEGUNDO BOTON +++++++++++++++++++**/
                        //VID 66,PASO 90
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
                    //Paso 43, agregamos un spacer
                    Spacer(minLength: 95)
                }
                //Paso 36
                .frame(width: geo.size.width,height: geo.size.height)
            }
            //Paso 34, centramos la imégen del background con el geometry
            .frame(width: geo.size.width,height: geo.size.height)
        }
        //Paso 32,para que ignore el safarea
        .ignoresSafeArea()
        //Paso 62, enseñamos el personaje con el sheet.
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

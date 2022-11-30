//
//  ContentView.swift
//  EuroDigitale_WithFramework
//
//  Created by Emanuele Mele on 25/08/22.
//

import Foundation
import SwiftUI
import FEuroDigitale

struct ContentView: View {
    var body: some View {
        NavigationView {
            mainView().offset(y: -0)
        }
        //only for view test
        //exchangeView().offset(y: -0)
    }
}

struct mainView: View {
    
    @State private var NElement = 0
    @State private var NEXElement = 0
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Button(action: {
                NElement = getNElement()
                NEXElement = getNEXElement()
            }, label: {
                HStack {
                    Image(systemName: "a.magnify").resizable()
                        .foregroundColor(Color.black)
                        .frame(width: 30.0, height: 30.0)
                    
                    VStack{
                        Text("Token: " + String(NElement)).foregroundColor(.black)
                        Text("Exchange Token: " + String(NEXElement)).foregroundColor(.black)
                        
                    }
                   
                }
                
            })
            
            NavigationLink(destination: testView(), label: {Text("TestView")})
            
            Divider()
            
            VStack {
                
                Spacer()
                
                HStack{
                    
                    Button(action: {
                        alertViewVirtualToToken()
                        NElement = getNElement()
                        NEXElement = getNEXElement()
                    }, label: {
                        VStack {
                            Image(systemName: "arrow.up").resizable()
                                .foregroundColor(Color.black)
                                .frame(width: 30.0, height: 40.0)
                            Text("Withdraw").foregroundColor(.black)
                        }
                        
                    }).padding()
                    
                    Button(action: {
                        alertViewExchangeToEX()
                        NEXElement = getNEXElement()
                        NEXElement = getNEXElement()
                    }, label: {
                        VStack {
                            Image(systemName: "arrow.up").resizable()
                                .foregroundColor(Color.black)
                                .frame(width: 30.0, height: 40.0)
                            Text("Withdraw \nExchange").foregroundColor(.black)
                        }
                        
                    }).padding()
                    
                }
                
                
                HStack {
                    
                    NavigationLink(destination: exchangeView(), label: {
                        
                        VStack {
                            Image(systemName: "arrow.swap").resizable()
                                .foregroundColor(Color.black)
                                .frame(width: 40.0, height: 40.0)
                            Text("Exchange").foregroundColor(.black)
                        }
                        
                    }).padding()
                    
                    Button(action: {
                        
                        let controlJson = HomePage()
                        controlJson.DepositSE()
                        controlJson.Deposit()
                        NElement = getNElement()
                        NEXElement = getNEXElement()
                    }, label: {
                        
                        VStack {
                            Image(systemName: "arrow.down").resizable()
                                .foregroundColor(Color.black)
                                .frame(width: 30.0, height: 40.0)
                            Text("Deposits").foregroundColor(.black)
                        }
                        
                    }).padding()
                    
                }
                
                Spacer()
                
            }
            
        }
        
    }
}

struct exchangeView: View {
    
    @State private var requestImport: String = ""
    @State private var Import: String = ""
    @State var myString = "String"
    @StateObject var mySession = MultipeerSession()
    @State var isHidden = false
    @State var isHidden1 = true
    
    @State private var showAlert = false
    
    var body: some View {
        
        VStack(){
            
            VStack{
                
                VStack{
                    Text("Connected Devices: ").bold().font(.system(size: 20))
                    Text(String(describing: mySession.getConnectedPeers().map(\.displayName))).font(.system(size: 14))
                }
                
                HStack(){
                    
                    Button(action: {
                        mySession.start()
                    }, label: {
                        
                        VStack {
                            Image(systemName: "antenna.radiowaves.left.and.right").resizable()
                                .foregroundColor(Color.black)
                                .frame(width: 35.0, height: 30.0)
                            Text("CONNECT").foregroundColor(.black)
                        }
                        
                    }).padding()

                    Button(action: {
                        mySession.stop()
                    }, label: {
                        
                        VStack {
                            Image(systemName: "antenna.radiowaves.left.and.right").resizable()
                                .foregroundColor(Color.black)
                                .frame(width: 35.0, height: 30.0)
                            Text("DISCONNECT").foregroundColor(.black)
                        }
                        
                    }).padding([.horizontal], 10)

                    
                }
                
            }
            
            
            Divider()
            
            VStack(){
                Button("REQUEST ZONE "){
                    isHidden.toggle()
                    isHidden1.toggle()
                }
                //Text("REQUEST ZONE ").bold().padding()
                HStack{
                    Text("Write yout import: ").padding()
                    TextField("55", text: $requestImport).keyboardType(.decimalPad)
                }.opacity(isHidden ? 0 : 1)
                
                HStack {
                    Button(action: {
                        
                        Exchange.request(mySession: mySession, requestImport: requestImport)
                        
                    }, label: {
                        
                        VStack {
                            Image(systemName: "person.fill.questionmark").resizable()
                                .foregroundColor(Color.black)
                                .frame(width: 40.0, height: 30.0)
                            Text("REQUEST").foregroundColor(.black)
                        }
                        
                    }).padding()
                    
                    Button(action: {
                        
                        Exchange.save(mySession: mySession)
                      
                    }, label: {
                        
                        VStack {
                            Image(systemName: "square.and.arrow.down").resizable()
                                .foregroundColor(Color.black)
                                .frame(width: 30.0, height: 30.0)
                            Text("SAVE").foregroundColor(.black)
                        }
                        
                    }).padding()
                }.opacity(isHidden ? 0 : 1)
                
            }
            
            Divider()
            
            VStack(){
                
                Button("SENDING ZONE "){
                    isHidden1.toggle()
                    isHidden.toggle()
                }
                
                VStack{
                    Text("Amount requested: " + mySession.getmyString()).font(.system(size: 23)).foregroundColor(.red).textCase(.uppercase)
                    Text("Send ?").font(.system(size: 23)).textCase(.uppercase)
                    
                }.opacity(isHidden1 ? 0 : 1)

                HStack(){
                    
                    
                    Button(action: {
                        
                        Exchange.accept(mySession: mySession)
                        
                    }, label: {
                        
                        VStack {
                            Image(systemName: "person.fill.checkmark").resizable()
                                .foregroundColor(Color.black)
                                .frame(width: 40.0, height: 30.0)
                            Text("ACCEPT").foregroundColor(.black)
                        }
                        
                    }).padding().alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Accepted"),
                            message: Text("You have accepted the money transfer !")
                        )
                    }
                    
                    
                    Button(action: {
                        mySession.stop()
                    }, label: {
                        
                        VStack {
                            Image(systemName: "person.fill.xmark").resizable()
                                .foregroundColor(Color.black)
                                .frame(width: 40.0, height: 30.0)
                            Text("REJECT").foregroundColor(.black)
                        }
                        
                    }).padding()

                    
                }.opacity(isHidden1 ? 0 : 1)
                
                
                
            }
            

        }.offset(y: -45)
        
    }
    
}


//test 
struct testView: View {
    
    //var strings = Exchange.getAllKey()
    @State var strings: [String] = []
    
    var body: some View {
        
        VStack {
            
            Button("Refresh"){
                self.strings = Exchange.getAllKeySE()
            }
            
            List(strings, id: \.self) { string in
                        Text(string)
                    }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

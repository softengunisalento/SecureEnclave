//
//  EuroDigitale_WithFrameworkApp.swift
//  EuroDigitale_WithFramework
//
//  Created by Emanuele Mele on 25/08/22.
//

import SwiftUI
import FEuroDigitale
import Foundation

@main
struct EuroDigitale_WithFrameworkApp: App {
    
    init(){
    }

    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

public func alertViewVirtualToToken(){
    
    //Creo la schermata dell'Alert
    let alert = UIAlertController(title: "Transfer money", message: "Transfer from account to local", preferredStyle: .alert)
    
    //Creo il textField e metto il suo contenuto in una variabile @State
    alert.addTextField(){
        saldoVirtualeToToken in saldoVirtualeToToken.placeholder = "100"
    }
    
    //Creo il bottone per inviare
    let sendActionVTT = UIAlertAction(title: "Transfer", style: .default) {(_) in
        
        /*
        let controlJson = HomePage()
        controlJson.Withdraw()
        */
        
        let test = GenerateTestInformation()
        //let start = CFAbsoluteTimeGetCurrent()
        test.generateRandomTokenSE(number: Int(alert.textFields![0].text!)!)
        //let diff = CFAbsoluteTimeGetCurrent() - start
        //print("Took \(diff) seconds")
    
    }
    
    //Creo il bottone per tornare indietro
    let cancelActionVTT = UIAlertAction(title: "Back", style: .destructive) {(_) in
        
        print("Indietro")}
    
    //Aggiungo i bottoni nell'aletrt
    alert.addAction(sendActionVTT)
    alert.addAction(cancelActionVTT)
    
    //Rendo visibile l'alert
    UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
        //Fare qualcosa quando si preme il pulsante
        
    })
    
}

public func alertViewExchangeToEX(){
    
    //Creo la schermata dell'Alert
    let alert = UIAlertController(title: "Get exchange keys", message: "Number of keys", preferredStyle: .alert)
    
    //Creo il textField e metto il suo contenuto in una variabile @State
    alert.addTextField(){
        saldoVirtualeToToken in saldoVirtualeToToken.placeholder = "50"
    }
    
    //Creo il bottone per inviare
    let sendActionVTT = UIAlertAction(title: "Get", style: .default) {(_) in
        
       let test = GenerateTestInformation()
       test.generateRandomKeySE(number: Int(alert.textFields![0].text!)!)
        
        /*
        let controlJson = HomePage()
        controlJson.WithdrawExchange()
         */
    
    }
    
    //Creo il bottone per tornare indietro
    let cancelActionVTT = UIAlertAction(title: "Back", style: .destructive) {(_) in
        
        print("Indietro")}
    
    //Aggiungo i bottoni nell'aletrt
    alert.addAction(sendActionVTT)
    alert.addAction(cancelActionVTT)
    
    //Rendo visibile l'alert
    UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
        //Fare qualcosa quando si preme il pulsante
    })
    
}

public func alertViewExchangeToken(){
    
    //Creo la schermata dell'Alert
    let alert = UIAlertController(title: "Scambio di denaro", message: "Richiedi una cifra", preferredStyle: .alert)
    
    //Creo il textField e metto il suo contenuto in una variabile @State
    alert.addTextField(){
        saldoVirtualeToToken in saldoVirtualeToToken.placeholder = "10.00€"
    }
    
    //Creo il bottone per inviare
    let sendActionVTT = UIAlertAction(title: "Richiedi", style: .default) {(_) in
        
        let controlJson = HomePage()
        controlJson.Exchange()
    
    }
    
    //Creo il bottone per tornare indietro
    let cancelActionVTT = UIAlertAction(title: "Indietro", style: .destructive) {(_) in
        
        print("Indietro")}
    
    //Aggiungo i bottoni nell'aletrt
    alert.addAction(sendActionVTT)
    alert.addAction(cancelActionVTT)
    
    //Rendo visibile l'alert
    UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
        //Fare qualcosa quando si preme il pulsante
    })
    
}

public func getNElement() -> Int {
    let nElement = HomePage()
    return nElement.getNElement()
}

public func getNEXElement() -> Int {
    let nElement = HomePage()
    return nElement.getNElementExchange()
}

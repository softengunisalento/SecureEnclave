/*
La relazione che è presente è data da uno schema 1:1 , ovvero ad una chiave corrisponde un valore,
SEValent può contenere più coppie di chiave valore.
Queste funzioni funzionanano se l'iphone ha una password per sbloccare il dispositivo o
qualsiasi altro metodo di sblocco
 */

import Foundation
import Valet

public class SecureEnclave{
    
    private var identifier: Identifier
    private var mySEValet : SinglePromptSecureEnclaveValet
    
    init(){
        self.identifier = Identifier(nonEmpty: "default")!
        self.mySEValet = SinglePromptSecureEnclaveValet.valet(with: identifier, accessControl: .userPresence)
        
    }
    
    //Identificatore utilizzato per accedere al portachiavi SE iteressato
    func setIdentifierCode(_ identifierKey: String) {
        self.identifier = Identifier(nonEmpty: identifierKey)!
    }
    
    //Creazione di un portachiavi con l'utilizzo del Secure Enclave
    func createSEValet(_ identifierKey: String) {
        setIdentifierCode(identifierKey)
        self.mySEValet = SinglePromptSecureEnclaveValet.valet(with: self.identifier, accessControl: .userPresence)
    }
    
    //Verifico se ho accesso al portachiavi SE
    func verifyAccessToSEValet(){
        print("Accesso al portachiavi SE: " + String(self.mySEValet.canAccessKeychain()))
    }
    
    //Inserire una stringa nel mio portachiavi SE , richiede la parola che vogliamo prodeggere e la sua chiave per crittografarla
    func addWordInSEValet(_ word: String, _ key: String){
        try? self.mySEValet.setString(word, forKey: key)
        //print("Parola aggiunto al portachiavi SE")
    }
    
    //Verificare se il portachiavi SE contiene oggetti
    func checkObjectSEValetByKey(_ key: String){
        let check = try? self.mySEValet.containsObject(forKey: key)
        var yesORno: String
        if(check == true){
            yesORno = "contiene"
        }else {
            yesORno = "non contiene"
        }
        
        print("Il portachiavi SE con key: " + key + " - " + yesORno + " elementi")
    }
    
    //Stampa della mia parola
    //La visualizzazione dell'informazione richiede dati biometrici
    func printMyWordInSEValetByKey(_ key: String){
        let myWord = try? mySEValet.string(forKey: key, withPrompt: "")
        // userPrompt: The prompt displayed to the user in Apple's Face ID, Touch ID, or passcode entry UI.
        print("Valore associato a questa chiave : " + String(describing: myWord))
    }
    
    func getMyWordInSEValetByKey(_ key: String) -> String{
        let myWord = try? mySEValet.string(forKey: key, withPrompt: "")
        return myWord ?? "error"
    }
    
    //Eliminazione di un elemento data una chiave
    func removeWordFromKeySEValet(_ key: String){
        try? mySEValet.removeObject(forKey: key)
        //print("Rimosso elemento con chiave: " + key)
    }
    
    //Elimina tutte le chiavi e le parole
    func removeAllInSEValet(){
        try? mySEValet.removeAllObjects()
        print("Hai rimosso tutto!")
    }
    
}

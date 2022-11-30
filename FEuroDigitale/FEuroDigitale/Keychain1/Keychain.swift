/*
La relazione che è presente è data da uno schema 1:1 , ovvero ad una chiave corrisponde un valore, un
Valent può contenere
più coppie di chiave valore. Creare un nuovo Valent con lo stesso identificatore non creerà una nuova
zona ma riprenderà
la vecchia.
 */

import Foundation
import Valet

public class Keychain{
    
    private var identifier: Identifier
    private var myValet: Valet
    
    init(){
        self.identifier = Identifier(nonEmpty: "default")!
        self.myValet = Valet.valet(with: self.identifier, accessibility: .whenUnlocked)
    }
    
    //Identificatore utilizzato per accedere al portachiavi iteressato
    func setIdentifierCode(_ identifierKey: String) {
        self.identifier = Identifier(nonEmpty: identifierKey)!
    }
    
    //Creazione di un portachiavi con un identifier
    func createValet( _ identifierKey: String){
        setIdentifierCode(identifierKey)
        self.myValet = Valet.valet(with: self.identifier, accessibility: .whenUnlocked)
    }
    
    //Verifico se ho accesso al portachiavi
    func verifyAccessToValet(){
        print("Accesso al portachiavi: " + String(self.myValet.canAccessKeychain()))
    }
    
    //Inserire una stringa nel mio portachiavi, richiede la parola che vogliamo prodeggere e la sua chiave per crittografarla
    func addWordInValet(_ word: String, _ key: String){
        try? self.myValet.setString(word, forKey: key)
        //print("Parola aggiunto al portachiavi")
    }
    
    //Verificare se il portachiavi contiene oggetti
    func checkObjectValetByKey(_ key: String){
        let check = try? self.myValet.containsObject(forKey: key)
        var yesORno: String
        if(check == true){
            yesORno = "contiene"
        }else {
            yesORno = "non contiene"
        }
        
        print("Il portachiavi con key: " + key + " - " + yesORno + " elementi")
    }
    
    //Stampa della mia parola
    func printMyWordInValetByKey(_ key: String){
        let myWord = try? myValet.string(forKey: key)
        print("Valore associato a questa chiave : " + (myWord ?? "chiave non esistente"))
    }
    
    func getMyWordInValetByKey(_ key: String) -> String {
        let myWord = try? myValet.string(forKey: key)
        return (myWord ?? " ")
    }
    
    //Stampa di tutte le mie chiavi
    func printAllMyKeyInValet(){
        let myWords = try! myValet.allKeys()
        print("Tutte le mie chiavi: ")
        for elem in myWords {
            print(elem)
        }
    }
    
    func getAllMyKeyInValent() -> [String] {
        let myWords = try! myValet.allKeys()
        var array = [String]()
        for elem in myWords {
            array.append(elem)
        }
        return array.sorted()
    }
    
    //Eliminazione di un elemento data una chiave
    func removeWordFromKeyValet(_ key: String){
        try? myValet.removeObject(forKey: key)
        //print("Rimosso elemento con chiave: " + key)
    }
    
    //Elimina tutte le chiavi e le parole
    func removeAllInValet(){
        try? myValet.removeAllObjects()
        print("Hai rimosso tutto!")
    }
    
    
}

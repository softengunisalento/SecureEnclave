import Foundation

/*
 https://www.youtube.com/watch?v=p1UNnsodJxc&ab_channel=iOSMastery
 tutorial sulla gestione dei file in ios
 */

public class HomePage: NSObject {
    
    //number of token in my Valent
    private var NElement = 0
    
    private var unique = 0
    
    //number of exchange key in my Valet
    private var NEXElement = 0
    
    private var uniqueEX = 0
    
    public override init(){}
    
    //Function to check if json already used
    public func Withdraw(){
        
        /**
         Standard Key for Valent:
            NElement: è la chiave che mi ritorna il numero di token presenti nel mio valent
            NameElement + "n": example NameElement3; è la chiave utilizzata per prendere i nomi dei valent (che serviranno per accedere ai token), per esempio NameElement1 -> AAAAA
            token + verification: example tokenAAAAA; è la chiave utilizzata per accedere ai token, per esempio tokenAAAAA -> CodiceToken
            key + verification: example keyAAAAA; è la chiave utilizzata per accedere alle chiavi di scambio, per esempio keyAAAAA -> CodiceKey
            il campo "exchange" + exchangeVerification serve per verificare se la chiave di scambio è già stata utilizzata all'interno del mio valent, quindi mi ridarà una cosa del tipo exchangeEXAAA0 -> EXAAA0
                
         **/
        
        let njson = ReadNJson()
        njson.parseJson(fileName: "njson.json")
        let myNames = njson.getNJson()
        
        //name element
        var NameElement = ""
        
        for fileName in myNames {
            
            let readJson = ReadJson()
            readJson.parseJson(fileName: fileName)
            print(fileName)
            
            //Get verification of json code
            let myHeader = readJson.getJsonHeader()
            let verification = myHeader[0]
            
            
            //Set the keychain verification with json code
            let keyChain = Keychain()
            keyChain.setIdentifierCode(verification)
            //keyChain.removeAllInValet()
            
            //Get number of elemente in Valent
            if(keyChain.getMyWordInValetByKey("NElement") == " ")
            {
                keyChain.addWordInValet(String(NElement), "NElement")
            }
            else{
                NElement = Int(keyChain.getMyWordInValetByKey("NElement")) ?? 111
            }
            
            
            //Validate json
            if (keyChain.getMyWordInValetByKey("token"+verification) == " ") {
                
                keyChain.addWordInValet(myHeader[1], "token" + verification)
                keyChain.addWordInValet(myHeader[2], "key" + verification)
                
                NElement = NElement + 1
                keyChain.addWordInValet(String(NElement), "NElement")
                
                NameElement = verification
                
                ///Controllo che l'elemento da inserire non abbia un identificativo nel valent
                ///uguale ad altri altrimenti andrebbe sovrascritto.
                
                if(keyChain.getMyWordInValetByKey("unique") == " "){
                    keyChain.addWordInValet(String(unique), "unique")
                }else{
                    unique = Int(keyChain.getMyWordInValetByKey("unique")) ?? 111
                }
                
                var tempNumber = unique
                var controlNumber = 0
                while controlNumber == 0{
                    if(keyChain.getMyWordInValetByKey("NameElement" + String(tempNumber)) == " "){
                        keyChain.addWordInValet(NameElement, "NameElement" + String(tempNumber))
                        tempNumber = tempNumber + 1
                        keyChain.addWordInValet(String(tempNumber), "unique")
                        controlNumber = 1
                    }else {
                        tempNumber = tempNumber + 1
                    }
                }
                
                
                
                //let myString = readJson.getJsonData()
                //CPPWrapper().cppWrapper(myString);
                
            }else{
                print("Json già letto!")
                //test print
                
                /*
                print(verification)
                print("Token:" + keyChain.getMyWordInValetByKey("token"+verification))
                print("Chiave:" + keyChain.getMyWordInValetByKey("key"+verification))
                */
                
                 
            }
        
            print()
            
        }
        
        
    }
    
    
    public func WithdrawExchange(){
    
        //Read number of json
        let njson = ReadNJson()
        njson.parseJson(fileName: "nexchange.json")
        let myNames = njson.getNJson()
        
        for fileName in myNames {
            
            //Parse Json
            let readJson = ReadExchange()
            readJson.parseJson(fileName: fileName)
            
            //Get element by json
            let myFile = readJson.getJsonExchange()
            
            let exchangeVerification = myFile[0]
            let exchange = myFile[1]
            
            //Start Valent
            let keyChain = Keychain()
            keyChain.setIdentifierCode("default")
            
            //Get number of exchange elemente in Valent
            if(keyChain.getMyWordInValetByKey("NEXElement") == " ")
            {
                keyChain.addWordInValet(String(NEXElement), "NEXElement")
            }
            else{
                NEXElement = Int(keyChain.getMyWordInValetByKey("NEXElement")) ?? 111
            }
            
            //Validate json
            if(keyChain.getMyWordInValetByKey("exchange" + exchangeVerification) == " "){
                
                keyChain.addWordInValet(myFile[1], "exchange" + exchangeVerification)
                
                NEXElement = NEXElement + 1
                keyChain.addWordInValet(String(NEXElement), "NEXElement")
                
                let NameEXElement = exchangeVerification
                
                ///Controllo che l'elemento da inserire non abbia un identificativo nel valent
                ///uguale ad altri altrimenti andrebbe sovrascritto.
                
                if(keyChain.getMyWordInValetByKey("uniqueEX") == " "){
                    keyChain.addWordInValet(String(uniqueEX), "uniqueEX")
                }else{
                    uniqueEX = Int(keyChain.getMyWordInValetByKey("uniqueEX")) ?? 111
                }
                
                var tempNumber = uniqueEX
                var controlNumber = 0
                while controlNumber == 0{
                    if(keyChain.getMyWordInValetByKey("NameEXElement" + String(tempNumber)) == " "){
                        keyChain.addWordInValet(NameEXElement, "NameEXElement" + String(tempNumber))
                        tempNumber = tempNumber + 1
                        keyChain.addWordInValet(String(tempNumber), "uniqueEX")
                        controlNumber = 1
                    }else {
                        tempNumber = tempNumber + 1
                    }
                }
                
                
                print("NEXElement : " + String(keyChain.getMyWordInValetByKey("NEXElement")))
                print("NameEXElemnt" + String(tempNumber - 1) + " : " + keyChain.getMyWordInValetByKey("NameEXElement" + String(tempNumber - 1)))
                print("exchange" + exchangeVerification + " : " + keyChain.getMyWordInValetByKey("exchange" + exchangeVerification))
                
            }else{
                print("Json già letto!")
                
            }
            
            
        }
        
    }
    
    //Function for key exchange
    public func Exchange(){
        
        //Read number of json
        let njson = ReadNJson()
        njson.parseJson(fileName: "nexchange.json")
        let myNames = njson.getNJson()
        
        for fileName in myNames {
            
            print(fileName)
            //Parse Json
            let readJson = ReadExchange()
            readJson.parseJson(fileName: fileName)
            
            //Get element by json
            let myFile = readJson.getJsonExchange()
           
            //Start Valent
            let keyChain = Keychain()
            keyChain.setIdentifierCode("default")
            
            let exchangeVerification = myFile[0]
            
            //Array with all key in valent
            let arrayNametemp = keyChain.getAllMyKeyInValent()
            
            //Array with NameElement Key in valent
            var arrayName = [String]()
            
            for name in arrayNametemp {
                if(name.hasPrefix("NameElement")){
                    arrayName.append(name)
                }
            }
            
            var insertOk = 0
            
            //Add key in token
            for name in arrayName {
                
                if insertOk == 0 {
                    
                    let verification = keyChain.getMyWordInValetByKey(name)
                    
                    if(keyChain.getMyWordInValetByKey("key" + verification) == " "){
                            
                            if (keyChain.getMyWordInValetByKey("exchange" + exchangeVerification) == " ") {
                                
                                keyChain.addWordInValet(myFile[1], "key" + verification)
                                keyChain.addWordInValet(myFile[0], "exchange" + exchangeVerification)
                                
                                //print(keyChain.getMyWordInValetByKey("token" + verification))
                                //print(keyChain.getMyWordInValetByKey("key" + verification))
                                
                                var NElement = Int(keyChain.getMyWordInValetByKey("NElement"))
                                NElement = (NElement ?? 111) - 1
                                keyChain.addWordInValet(String(NElement!), "NElement")
                                print("Chiave inserita correttamente")
                                insertOk = 1
                                
                            }
                            else {
                                print("Chiave di scambio già utilizzata")
                            }
                    
                    }
                    
                }
            }
            
        }
        
        
    }
    
    public func Deposit() {
        let keyChain = Keychain()
        keyChain.setIdentifierCode("default")
        keyChain.printAllMyKeyInValet()
        keyChain.removeAllInValet()
    }
    
    public func DepositSE() {
        let secureEnclave = SecureEnclave()
        secureEnclave.setIdentifierCode("default")
        secureEnclave.removeAllInSEValet()
    }
    
    public func getNElement() -> Int {
        
        let keyChain = Keychain()
        keyChain.setIdentifierCode("default")
        
        //Get number of elemente in Valent
        if(keyChain.getMyWordInValetByKey("NElement") == " ")
        {
            keyChain.addWordInValet(String(NElement), "NElement")
        }
        else{
            NElement = Int(keyChain.getMyWordInValetByKey("NElement")) ?? 111
        }
        
        return NElement
        
    }
    
    public func getNElementExchange() -> Int {
        
        let keyChain = Keychain()
        keyChain.setIdentifierCode("default")
        
        //Get number of elemente in Valent
        if(keyChain.getMyWordInValetByKey("NEXElement") == " ")
        {
            keyChain.addWordInValet(String(NEXElement), "NEXElement")
        }
        else{
            NEXElement = Int(keyChain.getMyWordInValetByKey("NEXElement")) ?? 111
        }
        
        return NEXElement
        
    }
    
  
    
    
}

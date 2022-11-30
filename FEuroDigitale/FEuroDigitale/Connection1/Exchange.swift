import Foundation

public class Exchange{
    
    private static var keychain = Keychain()
    private static var secureEnclave = SecureEnclave()
    private static var myArrayStringSend: [String] = []
    private static var myArrayStringRequest: [String] = []
    
    //Array with NameEXElement Key in valent
    private static var arrayName: [String] = []
    
    public init(){}
    
    static func checkNumberOfExchangeKey(numberExchange: Int) -> Bool {
        
        keychain.setIdentifierCode("default")
        
        var value : Int
        if (keychain.getMyWordInValetByKey("NEXElement") == " ") {
            value = 0
        }else {
            value = Int(keychain.getMyWordInValetByKey("NEXElement"))!
        }
        
        if (value < numberExchange) {
            print("Non ci sono abbstanza token")
            return false
        }else {
            return true
        }
        
    }
    
    
    public static func getExchangeKey(numberExchange: Int) -> [String] {
        
        var myArrayStringRequest: [String] = []
        
        keychain.setIdentifierCode("default")
        
        //Array with all key in valent
        let arrayNametemp = keychain.getAllMyKeyInValent()
        
        //Array with NameEXElement Key in valent
        arrayName = [String]()
        
        for name in arrayNametemp {
            if(name.hasPrefix("NameEXElement")){
                if (keychain.getMyWordInValetByKey(name) != " ") {
                    arrayName.append(name)
                }
            }
        }
        
        if numberExchange != 0 {
            for i in 0...(numberExchange-1) {
                let verification = keychain.getMyWordInValetByKey(arrayName[i])
                let exchange = keychain.getMyWordInValetByKey("exchange" + verification)
                myArrayStringRequest.append(verification)
                myArrayStringRequest.append(exchange)
            }
        }
    
        return myArrayStringRequest
    }
    
    public static func getExchangeKeySE(numberExchange: Int) -> [String] {
        
        var myArrayStringRequest: [String] = []
        
        keychain.setIdentifierCode("default")
        secureEnclave.setIdentifierCode("default")
        
        //Array with all key in valent
        let arrayNametemp = keychain.getAllMyKeyInValent()
        
        //Array with NameEXElement Key in valent
        arrayName = [String]()
        
        for name in arrayNametemp {
            if(name.hasPrefix("NameEXElement")){
                if (keychain.getMyWordInValetByKey(name) != " ") {
                    arrayName.append(name)
                }
            }
        }
        
        if numberExchange != 0 {
            for i in 0...(numberExchange-1) {
                let verification = keychain.getMyWordInValetByKey(arrayName[i])
                let exchange = secureEnclave.getMyWordInSEValetByKey("exchange" + verification)
                myArrayStringRequest.append(verification)
                myArrayStringRequest.append(exchange)
            }
        }
    
        return myArrayStringRequest
    }
    
    
    static func checkNumberOfToken(numberExchange: Int) -> Bool{
        
        keychain.setIdentifierCode("default")
        
        var value : Int
        if (keychain.getMyWordInValetByKey("NElement") == " ") {
            value = 0
        }else {
            value = Int(keychain.getMyWordInValetByKey("NElement"))!
        }
        
        if (value < numberExchange) {
            print("Non ci sono abbstanza token")
            return false
        }else {
            return true
        }
        
    }
    
    public static func request(mySession: MultipeerSession,requestImport: String){
        
        let bool = Exchange.checkNumberOfExchangeKey(numberExchange: Int(requestImport) ?? 0)
        
        if bool {
            myArrayStringRequest = Exchange.getExchangeKeySE(numberExchange: Int(requestImport) ?? 0)
            mySession.send(ArrayString: myArrayStringRequest)
        }
    }
    
    static func getToken(numberExchange: Int, ExchangeKey: [String]) -> [String] {
        
        var myArrayStringRequest: [String] = []
        
        keychain.setIdentifierCode("default")
        
        //Array with all key in valent
        let arrayNametemp = keychain.getAllMyKeyInValent()
        
        //Array with NameEXElement Key in valent
        var arrayName = [String]()
        
        for name in arrayNametemp {
            if(name.hasPrefix("NameElement")){
                if (keychain.getMyWordInValetByKey(name) != " ") {
                    arrayName.append(name)
                }
            }
        }
        
        
        if numberExchange != 0 {
            for i in 0...(numberExchange-1) {
                let verification = keychain.getMyWordInValetByKey(arrayName[i])
                let token = keychain.getMyWordInValetByKey("token" + verification)
                
                //I remove the transfered token
                keychain.removeWordFromKeyValet("token" + verification)
                //Add the key with the key used for exchange
                keychain.addWordInValet(ExchangeKey[i], "key" + verification)
                //Update the number of token
                var NElement = Int(keychain.getMyWordInValetByKey("NElement"))
                NElement = NElement! - 1
                keychain.addWordInValet(String(NElement!), "NElement")
                
                myArrayStringRequest.append(verification)
                myArrayStringRequest.append(token)
            }
        }
    
        return myArrayStringRequest
    }
    
    static func getTokenSE(numberExchange: Int, ExchangeKey: [String]) -> [String] {
        
        var myArrayStringRequest: [String] = []
        
        keychain.setIdentifierCode("default")
        secureEnclave.setIdentifierCode("default")
        
        //Array with all key in valent
        let arrayNametemp = keychain.getAllMyKeyInValent()
        
        //Array with NameEXElement Key in valent
        var arrayName = [String]()
        
        for name in arrayNametemp {
            if(name.hasPrefix("NameElement")){
                if (keychain.getMyWordInValetByKey(name) != " ") {
                    arrayName.append(name)
                }
            }
        }
        
        
        if numberExchange != 0 {
            for i in 0...(numberExchange-1) {
                let verification = keychain.getMyWordInValetByKey(arrayName[i])
                let token = secureEnclave.getMyWordInSEValetByKey("token" + verification)
                
                //I remove the transfered token
                secureEnclave.removeWordFromKeySEValet("token" + verification)
                secureEnclave.removeWordFromKeySEValet("key" + verification)
                keychain.removeWordFromKeyValet("key" + verification)
                //Add the key with the key used for exchange
                secureEnclave.addWordInSEValet(ExchangeKey[i+1], "key" + verification)
                secureEnclave.addWordInSEValet(" ", "token" + verification)
                //Update the number of token
                var NElement = Int(keychain.getMyWordInValetByKey("NElement"))
                NElement = NElement! - 1
                keychain.addWordInValet(String(NElement!), "NElement")
                
                myArrayStringRequest.append(verification)
                myArrayStringRequest.append(token)
            }
        }
    
        return myArrayStringRequest
    }
    
    public static func SaveToken(tokenArray: [String]){
        
        keychain.setIdentifierCode("default")
        
        if tokenArray.count != 0{
            
            var i = 0
            var j = 0
            
            while i < tokenArray.count {
                
                //Saving Token
                var unique = Int(keychain.getMyWordInValetByKey("unique")) ?? 0
                keychain.addWordInValet(tokenArray[i], "NameElement" + String(unique))
                keychain.addWordInValet(tokenArray[i+1], "token" + tokenArray[i])
                unique = unique + 1
                keychain.addWordInValet(String(unique), "unique")
                
                var NElement = Int(keychain.getMyWordInValetByKey("NElement"))
                NElement = NElement! + 1
                keychain.addWordInValet(String(NElement!), "NElement")
                
                //Removing exchange key
                let verification = keychain.getMyWordInValetByKey(arrayName[j])
                keychain.removeWordFromKeyValet("exchange" + verification)
                keychain.removeWordFromKeyValet(arrayName[j])
                var NEXElement = Int(keychain.getMyWordInValetByKey("NEXElement"))!
                NEXElement = NEXElement - 1
                keychain.addWordInValet(String(NEXElement), "NEXElement")
                
                j = j + 1
                i = i + 2
                
            }
        }
        
    }
    
    public static func SaveTokenSE(tokenArray: [String]){
        
        keychain.setIdentifierCode("default")
        secureEnclave.setIdentifierCode("default")
        
        if tokenArray.count != 0{
            
            var i = 0
            var j = 0
            
            while i < tokenArray.count {
                
                //Saving Token
                var unique = Int(keychain.getMyWordInValetByKey("unique")) ?? 0
                keychain.addWordInValet(tokenArray[i], "NameElement" + String(unique))
                secureEnclave.addWordInSEValet(tokenArray[i+1], "token" + tokenArray[i])
                secureEnclave.addWordInSEValet(" ", "key" + tokenArray[i])
                unique = unique + 1
                keychain.addWordInValet(String(unique), "unique")
                
                var NElement = Int(keychain.getMyWordInValetByKey("NElement"))
                NElement = NElement! + 1
                keychain.addWordInValet(String(NElement!), "NElement")
                
                //Removing exchange key
                let verification = keychain.getMyWordInValetByKey(arrayName[j])
                secureEnclave.removeWordFromKeySEValet("exchange" + verification)
                keychain.removeWordFromKeyValet(arrayName[j])
                var NEXElement = Int(keychain.getMyWordInValetByKey("NEXElement"))!
                NEXElement = NEXElement - 1
                keychain.addWordInValet(String(NEXElement), "NEXElement")
                
                j = j + 1
                i = i + 2
                
            }
        }
        
    }
    
    public static func accept(mySession: MultipeerSession){
        //print("Start")
        //var time = [Double]()
        //for i in 0...1 { //test (remove for)
            let start = CFAbsoluteTimeGetCurrent()
            if(mySession.getmyArrayString().count != 0 ){
                
                let bool = Exchange.checkNumberOfToken(numberExchange: Int(mySession.getmyString()) ?? 0)
                
                if bool {
                    mySession.send(ArrayString: Exchange.getTokenSE(numberExchange: Int(mySession.getmyString()) ?? 0, ExchangeKey: mySession.getmyArrayString()))
                }
            }
            //let diff = CFAbsoluteTimeGetCurrent() - start
            //time.append(diff)
            //print("ACCEPT TIME " + String(i) + " : \(diff) seconds")
        //}
        //print("------------------------------------")
        //for i in 0...10 {
        //    print("ACCEPT TIME " + String(i) + " : \(time[i]) seconds")
        //}
    }
    
    public static func save(mySession: MultipeerSession){
        let start = CFAbsoluteTimeGetCurrent()
        Exchange.SaveTokenSE(tokenArray: mySession.getmyArrayString())
        let diff = CFAbsoluteTimeGetCurrent() - start
        print("SAVE TIME: \(diff) seconds")
    }
    
    //test
    public static func getAllKey() -> [String] {
        
        var allKey: [String] = []
        
        keychain.setIdentifierCode("default")
        
        for key in keychain.getAllMyKeyInValent() {
            let tmp = keychain.getMyWordInValetByKey(key)
            allKey.append(key + " : " + tmp)
        }
        
        return allKey
    }
    
    //test
    public static func getAllKeySE() -> [String] {
        
        var allKey: [String] = []
        
        keychain.setIdentifierCode("default")
        secureEnclave.setIdentifierCode("default")
        
        for key in keychain.getAllMyKeyInValent() {
            let tmp = keychain.getMyWordInValetByKey(key)
            allKey.append(key + " : " + tmp)
            if(secureEnclave.getMyWordInSEValetByKey("token"+tmp) != "error"){
                allKey.append("token"+tmp + " : " + secureEnclave.getMyWordInSEValetByKey("token"+tmp))
            }
            if(secureEnclave.getMyWordInSEValetByKey("key"+tmp) != "error"){
                allKey.append("key"+tmp + " : " + secureEnclave.getMyWordInSEValetByKey("key"+tmp))
            }
            if(secureEnclave.getMyWordInSEValetByKey("exchange"+tmp) != "error"){
                allKey.append("exchange"+tmp + " : " + secureEnclave.getMyWordInSEValetByKey("exchange"+tmp))
            }
        }
        
        return allKey
    }
    
    
}

import Foundation

public class GenerateTestInformation {
    
    public var keyChain = Keychain()
    public var secureEnclave = SecureEnclave()
    
    public init(){
        keyChain.setIdentifierCode("default")
        secureEnclave.setIdentifierCode("default")
    }
    
    public func generateRandomToken(number: Int){
        
        var temp = number
        
        while temp > 0 {
            
            let randomNumber = Int.random(in: 0...999)
            
            let nameElement = "NameElement" + String(randomNumber)
            let verification = randomString(length: 6)
            
            keyChain.addWordInValet(verification, nameElement)
            
            let tokenId = "token" + verification
            let token = randomString(length: 4)
            
            keyChain.addWordInValet(token, tokenId)
            
            let keyId = "key" + verification
            let key = " "
            
            keyChain.addWordInValet(key, keyId)
            temp = temp - 1
            
        }
        
        var NElemnt = Int(keyChain.getMyWordInValetByKey("NElement"))!
        NElemnt = NElemnt + number
        keyChain.addWordInValet(String(NElemnt), "NElement")
    }
    
    public func generateRandomTokenSE(number: Int){
        
        var temp = number
        
        while temp > 0 {
            
            let randomNumber = Int.random(in: 0...999)
            
            let nameElement = "NameElement" + String(randomNumber)
            let verification = randomString(length: 6)
            
            keyChain.addWordInValet(verification, nameElement)
            
            let tokenId = "token" + verification
            let token = randomString(length: 4)
            
            secureEnclave.addWordInSEValet(token, tokenId)
            
            let keyId = "key" + verification
            let key = " "
            
            keyChain.addWordInValet(key, keyId)
            temp = temp - 1
            
        }
        
        var NElemnt = Int(keyChain.getMyWordInValetByKey("NElement"))!
        NElemnt = NElemnt + number
        keyChain.addWordInValet(String(NElemnt), "NElement")
    }
    
    public func generateRandomKey(number:Int){
        
        var temp = number
        
        while temp > 0 {
            
            let randomNumber = Int.random(in: 0...999)
            
            let nameEXElement = "NameEXElement" + String(randomNumber)
            let verification = randomString(length: 6)
            
            keyChain.addWordInValet(verification, nameEXElement)
            
            let exchangeId = "exchange" + verification
            let exchange = randomString(length: 4)
            
            keyChain.addWordInValet(exchange, exchangeId)
            
            temp = temp - 1
        }
        var NEXElemnt = Int(keyChain.getMyWordInValetByKey("NEXElement"))!
        NEXElemnt = NEXElemnt + number
        keyChain.addWordInValet(String(NEXElemnt), "NEXElement")
        
    }
    
    public func generateRandomKeySE(number:Int){
        
        var temp = number
        
        while temp > 0 {
            
            let randomNumber = Int.random(in: 0...999)
            
            let nameEXElement = "NameEXElement" + String(randomNumber)
            let verification = randomString(length: 6)
            
            keyChain.addWordInValet(verification, nameEXElement)
            
            let exchangeId = "exchange" + verification
            let exchange = randomString(length: 4)
            
            secureEnclave.addWordInSEValet(exchange, exchangeId)
            
            temp = temp - 1
        }
        var NEXElemnt = Int(keyChain.getMyWordInValetByKey("NEXElement"))!
        NEXElemnt = NEXElemnt + number
        keyChain.addWordInValet(String(NEXElemnt), "NEXElement")
        
    }
    
    
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}

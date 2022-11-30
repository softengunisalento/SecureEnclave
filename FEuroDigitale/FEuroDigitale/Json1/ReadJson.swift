/* https://www.youtube.com/watch?v=g0kOJk4hTnY */

import Foundation
import SwiftUI

public class ReadJson{
    
    //Total result of Json
    private var result: Result?
    private var jsonData: Data?
    
    init(){}

    func parseJson(fileName: String){
        
        //Take a path of Json
        //take if is build on source code
        //guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {return}
        
        //encrypt file
        /*https://developer.apple.com/documentation/applearchive/encrypting_and_decrypting_a_single_file*/
       
        //general path
        let path = "/Users/emanuelemele/Desktop/Altro/XCodeProject/FEuroDigitale/FEuroDigitale/Json1/JsonFile/" + fileName;
        let url = URL(fileURLWithPath: path)
        
        do{
            //Try to open json
            jsonData = try Data(contentsOf: url)
            
            //Get all element of Json in Result
            result = try JSONDecoder().decode(Result.self, from: jsonData!)
            
            
        }catch{
            print("Error: \(error) ")
        }
        
    }
    
    //test
    func parseJsonFromDocumentDirectory(documentDirectory: URL, fileName: String){
        
        //Take a path of Json
        //take if is build on source code
        //guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {return}
        
        //encrypt file
        /*https://developer.apple.com/documentation/applearchive/encrypting_and_decrypting_a_single_file*/
       
        //general path
        let path = documentDirectory.appendingPathComponent(fileName)
        
        do{
            //Try to open json
            jsonData = try Data(contentsOf: path)
            
            //Get all element of Json in Result
            result = try JSONDecoder().decode(Result.self, from: jsonData!)
            
            
        }catch{
            print("Error: \(error) ")
        }
        
    }
    
    func getJsonData() -> Any? {
        return result
    }
    
    
    func getJsonData() -> String{
        
        var arrayResult = [String]()
        
        //Get the first object ed the first element inside Object
       // let resultTest = result?.index[0].token
        arrayResult.append(String(result?.index[0].verification ?? ""))
        arrayResult.append(String(result?.index[0].token ?? ""))
        arrayResult.append(String(result?.index[0].key ?? ""))
        
        var myString = "";
        var count = 0;
        
        //function to concatenate string with _
        for _ in arrayResult {
            myString = myString + arrayResult[count] + "_"
            count = count + 1
        }
        
        return myString
       
    }
    
    func getJsonHeader() -> [String] {
        
        var arrayResult = [String]()
        
        arrayResult.append(String(result?.index[0].verification ?? ""))
        arrayResult.append(String(result?.index[0].token ?? ""))
        arrayResult.append(String(result?.index[0].key ?? ""))

        return arrayResult
       
    }
    
    
    //Struct for Json Object
    struct Result: Codable {
        //The name of variable must be the same of the json label
        let index: [ResultInit]
    }
    
    //Struct for Json element inside a Json Object
    struct ResultInit: Codable {
        let verification: String
        let token: String
        let key: String
    }
    
    //Struct for json exchange element
    struct EResult: Codable {
        let verification: String
        let exchangeKey: String
    }

}

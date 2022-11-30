import Foundation

public class ReadExchange{
    
    //Total result of Json
    private var result: Result?
    
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
            let jsonData = try Data(contentsOf: url)
            
            //Get all element of Json in Result
            result = try JSONDecoder().decode(Result.self, from: jsonData)
            
            
        }catch{
            print("Error: \(error) ")
        }
        
    }
    
    func getJsonExchange() -> [String] {
        
        var arrayResult = [String]()
        
        arrayResult.append(String(result?.index[0].verification ?? ""))
        arrayResult.append(String(result?.index[0].exchange  ?? ""))
        
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
        let exchange: String
    }
    
}

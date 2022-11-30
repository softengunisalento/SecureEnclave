import Foundation

public class ReadNJson{
    
    //Total result of Json
    private var result: Response?
    
    init(){}
    
    func parseJson(fileName: String){
        
        //Take a path of Json
        //take if is build on source code
        //guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {return}
        
        //encrypt file
        /*https://developer.apple.com/documentation/applearchive/encrypting_and_decrypting_a_single_file*/
       
        //general path
        let path = "/Users/emanuelemele/Desktop/Altro/XCodeProject/FEuroDigitale/FEuroDigitale/Json1/JsonFile/" + fileName;
        print(path)
        let url = URL(fileURLWithPath: path)
        
        do{
            //Try to open json
            let jsonData = try Data(contentsOf: url)
            
            //Get all element of Json in Result
            result = try JSONDecoder().decode(Response.self, from: jsonData)
            
            
        }catch{
            print("Error: \(error) ")
        }
        
    }
    
    func getNJson() -> [String] {
        
        var arrayResult = [String]()
        
        for value in result!.index[0].values {
            arrayResult.append(String(value))
        }
     
        return arrayResult.sorted()

    }
    
    struct Response: Codable{
        var index: [[String:String]]
    }
    
}

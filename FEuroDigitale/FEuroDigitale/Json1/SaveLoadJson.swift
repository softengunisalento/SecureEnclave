import Foundation

public class SaveLoadJson {
    
    private var jsonData: Data?
    
    init(){}
    
    func getJsonObject(fileName: String) -> Data? {
        
        let path = "/Volumes/SSD Dev/Save/XCodeProject/EuroDigitale/EuroDigitale/Json/JsonFile/" + fileName;
        let url = URL(fileURLWithPath: path)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        //Try to open json
        jsonData = try? Data(contentsOf: url)

        let data = try? encoder.encode(jsonData)
    
        return data
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func saveDataToDocuments(_ data: Data, jsonFilename: String) {
        
        let jsonFileURL = getDocumentsDirectory().appendingPathComponent(jsonFilename)
        do {
           try data.write(to: jsonFileURL)
            print("File saved on Document Directory")
        } catch {
            print("Error = " + error.localizedDescription)
        }
    }
    
    
    //test
    func loadDataToDocuments(jsonFilename: String) {
        
        var url = URL(string: " ")
        url = getDocumentsDirectory()
        
        if let pathComponent = url?.appendingPathComponent(jsonFilename) {
              let filePath = pathComponent.path
              let fileManager = FileManager.default
              if fileManager.fileExists(atPath: filePath) {
                  let parse = ReadJson()
                  parse.parseJsonFromDocumentDirectory(documentDirectory: url!, fileName: jsonFilename)
              } else {
                  print("FILE NOT AVAILABLE")
              }
          } else {
              print("FILE PATH NOT AVAILABLE")
          }
    }
    
    func saveJson(fileName: String){
        saveDataToDocuments(getJsonObject(fileName: fileName)!,jsonFilename: fileName)
    }
    
    func loadJson(fileName: String){
        loadDataToDocuments(jsonFilename: fileName)
    }
    
    func checkElement(fileName: String){
        
        var url = URL(string: " ")
        url = getDocumentsDirectory()
        
        if let pathComponent = url?.appendingPathComponent(fileName) {
              let filePath = pathComponent.path
              let fileManager = FileManager.default
              if fileManager.fileExists(atPath: filePath) {
                  print("FILE AVAILABLE")
              } else {
                  print("FILE NOT AVAILABLE")
              }
          } else {
              print("FILE PATH NOT AVAILABLE")
          }
        
    }
    
    func removeJson(fileName: String){
        
        var url = URL(string: " ")
        url = getDocumentsDirectory()
        
        if let pathComponent = url?.appendingPathComponent(fileName) {
              let filePath = pathComponent.path
              let fileManager = FileManager.default
              if fileManager.fileExists(atPath: filePath) {
                  try? fileManager.removeItem(atPath: filePath)
                  print("FILE REMOVED")
              } else {
                  print("FILE NOT AVAILABLE")
              }
          } else {
              print("FILE PATH NOT AVAILABLE")
          }
        
    }
    
}
    


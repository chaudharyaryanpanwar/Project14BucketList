//
//  WritingDataToDocuments.swift
//  Project14BucketList
//
//  Created by Aryan Panwar on 11/08/24.
//

import SwiftUI

struct WritingDataToDocuments: View {
    var body: some View {
        Button("Read and Write"){
            let data = Data("Test Mesage".utf8)
            let url = URL.documentsDirectory.appending(path: "message.text")
            
            do {
                try data.write(to: url, options: [.atomic , .completeFileProtection])
                let input = try String(contentsOf: url)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        
    }
}

extension FileManager {
    
    var documentsDirectory : URL {
        return self.urls( for : .documentDirectory , in : .userDomainMask)[0]
    }
    
    func write <T : Codable>(_ object : T , to fileName : String){
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        encoder.dateEncodingStrategy = .formatted(formatter)
        
        do {
            let data = try encoder.encode(object)
            let url = documentsDirectory.appendingPathComponent(fileName)
            try data.write(to: url , options: [.atomic , .completeFileProtection])
        } catch {
            fatalError("Failed to write \(fileName) to documents directory : \(error.localizedDescription)")
        }
    }
    
//    Read a Codable object from a file in the documents directory
    func read <T: Codable>(_ fileName : String , as type : T.Type) -> T {
        let url = documentsDirectory.appendingPathComponent(fileName)
        
        guard let data = try? Data(contentsOf : url) else {
            fatalError("Failed to load \(fileName) from documents directory")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        do {
            return try decoder.decode(T.self , from: data)
        } catch DecodingError.keyNotFound(let key, let context ){
            fatalError("Failed to decode \(fileName) from documents directory due to missing key '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_ , let context){
            fatalError("Failed to decode \(fileName) from documents directory due to type mismatch - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type , let context){
            fatalError("Failed to decode \(fileName) from documents directory due to missing \(type) value - \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_){
            fatalError("Failed to decode \(fileName) fron documents directory because it appears to be invalid JSON.")
                       } catch {
                fatalError("Failed to decode \(fileName) from documents directory : \(error.localizedDescription)")
            }
    }
}

#Preview {
    WritingDataToDocuments()
}

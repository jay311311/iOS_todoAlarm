//
//  Storage.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/04/06.
//

import Foundation

public class Storage{
    private init() {}
    
    enum Directory {
        case documents
        case caches
        
        var url: URL {
            let path: FileManager.SearchPathDirectory
            switch self {
            case .documents:
                path = .documentDirectory
            case .caches:
                path = .cachesDirectory
            }
            return FileManager.default.urls(for: path, in: .userDomainMask).first!
        }
    }
    
    static func store<T:Encodable>(_ obj:T, to directory:Directory, as filename :String){
        // struct 형식의 Todo를 json파일로 encoding
        let url  =  directory.url.appendingPathComponent(filename, isDirectory: false)
        print("---> save to here: \(url)")
        let encoder =  JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do{
            let data = try encoder.encode(obj)
            if FileManager.default.fileExists(atPath: url.path){
              try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        }catch let error{
            print("what's the problem by encoder for store: \(error.localizedDescription)")
        }
    }
    
    static func retrive<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T? {
        let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
        print("---> retrive to here: \(url)")
        guard FileManager.default.fileExists(atPath: url.path) else { return nil }
        guard let data = FileManager.default.contents(atPath: url.path) else { return nil }
        
        let decoder = JSONDecoder()
   
        do {
          
            let model = try decoder.decode(type, from: data)
            print(model)
            return model
        } catch let error {
            print(" \(String(describing: error))")
            return nil
        }
    }
    
//    static func remove(_ fileName: String, from directory: Directory) {
//        let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
//        guard FileManager.default.fileExists(atPath: url.path) else { return }
//
//        do {
//            try FileManager.default.removeItem(at: url)
//        } catch let error {
//            print("---> Failed to remove msg: \(error.localizedDescription)")
//        }
//    }
//
//    static func clear(_ directory: Directory) {
//        let url = directory.url
//        do {
//            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
//            for content in contents {
//                try FileManager.default.removeItem(at: content)
//            }
//        } catch {
//            print("---> Failed to clear directory ms: \(error.localizedDescription)")
//        }
//    }
    
    
    
}

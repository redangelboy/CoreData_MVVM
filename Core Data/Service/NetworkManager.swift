//
//  NetworkManager.swift
//  Core Data
//
//  Created by Cesar Rojas on 11/27/22.
//

import Foundation

class NetworkManager {
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}

extension NetworkManager {
    
    func getInfo(with urlStr: String, completion: @escaping (MusicStructure?) -> Void) {
        
        guard let url = URL(string: urlStr) else {
            completion(nil)
            return
        }
        
        let task = self.session.dataTask(with: url) {data, response, error in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
//                print("decoding data")
                let musicStruc = try JSONDecoder().decode(MusicStructure.self, from: data)
//                print("Anyting")
                completion(musicStruc)
                
            }catch {
                print(error)
                completion(nil)
            }
            
            
            
        }
        task.resume()
    }
    
    func fetchImageData(path: String, completion: @escaping (Data?) -> Void) {
        
        guard let url = URL(string: path) else{
            completion(nil)
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(nil)
                return
            }
            
            completion(data)
            
        }
        task.resume()
    }
}

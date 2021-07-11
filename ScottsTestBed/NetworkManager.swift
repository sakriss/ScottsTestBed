//
//  NetworkManager.swift
//  ScottsTestBed
//
//  Created by Scott Kriss on 6/16/21.
//

import Foundation
import WebKit

class NetworkManager: Codable {

    static let shared = NetworkManager()
    static let dataParseComplete = Notification.Name("dataParseComplete")
    static let dataParseFailed = Notification.Name("dataParseFailed")
    var breeds: Breeds?
    
    func fetchData() {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(5)
        configuration.timeoutIntervalForResource = TimeInterval(5)
        
        let session = URLSession(configuration: configuration)
        let url = URL(string: "https://catfact.ninja/breeds")!

        let task = session.dataTask(with: url) { data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                NotificationCenter.default.post(name: NetworkManager.dataParseFailed, object: nil)
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                NotificationCenter.default.post(name: NetworkManager.dataParseFailed, object: nil)
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
                let dataString = String(data: data!, encoding: .utf8)
                print(dataString ?? "")
                self.breeds = ( try! JSONDecoder().decode(Breeds.self, from: data!))
                NotificationCenter.default.post(name: NetworkManager.dataParseComplete, object: nil)
            } catch {
                print("JSON error: \(error.localizedDescription)")
                NotificationCenter.default.post(name: NetworkManager.dataParseFailed, object: nil)
            }
        }

        task.resume()
    }
}

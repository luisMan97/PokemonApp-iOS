//
//  ApiManager.swift
//  PokemonAppValid
//
//  Created by Jorge Luis Rivera Ladino on 27/03/20.
//  Copyright © 2020 Jorge Luis Rivera Ladino. All rights reserved.
//

import UIKit
import Alamofire

class ApiManager {
    
    func callServiceObject(service: Router, withCompletionBlock: CallServiceHandlerWithAnyObject) {
        Alamofire.request(service)
            .responseJSON { response in
                switch response.result {
                case .success(let value):                 
                    if response.response?.statusCode == 404 {
                        let error = NSError(domain: "error", code: 404, userInfo: [NSLocalizedDescriptionKey: "404 error"])
                        withCompletionBlock?(nil, error)
                        return
                    }
                    
                    withCompletionBlock?(value, nil)
                    
                    break
                case .failure(let error):
                    self.logError(error, response: response)
                    
                    withCompletionBlock?(nil, error)
                    
                    break
                }
        }
    }

    func callSimpleGet(url: String, withCompletionBlock: CallServiceHandlerWithAnyObject) {
        Alamofire.request(url)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if response.response?.statusCode == 404 {
                        let error = NSError(domain: "error", code: 404, userInfo: [NSLocalizedDescriptionKey: "404 error"])
                        withCompletionBlock?(nil, error)
                        return
                    }
                    
                    withCompletionBlock?(value, nil)
                    
                    break
                case .failure(let error):
                    self.logError(error, response: response)
                    
                    withCompletionBlock?(nil, error)
                    
                    break
                }
        }
    }
    
    func callImage(url: String, withCompletionBlock: CallServiceHandlerWithData) {
        Alamofire.request(url, method: .get)
            .validate()
            .responseData { responseData in
                if let data = responseData.data {
                    withCompletionBlock?(data, nil)
                } else {
                    let error = NSError(domain: "error", code: 404, userInfo: [NSLocalizedDescriptionKey: "Download error image"])
                    withCompletionBlock?(nil, error)
                }
        }
    }
    
    func downloadedImage(from link: String, withCompletionBlock: CallServiceHandlerWithData) {
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil {
                DispatchQueue.main.async() {
                    withCompletionBlock?(data, nil)
                }
            } else {
                let error = NSError(domain: "error", code: 404, userInfo: [NSLocalizedDescriptionKey: "Download error image"])
                withCompletionBlock?(nil, error)
            }
        }.resume()
    }
    
    private func logError(_ error: Error, response: DataResponse<Any>) {
        print("\n\n===========Error===========")
        print("Error Code: \(error._code)")
        print("Error Messsage: \(error.localizedDescription)")
        if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
            print("Server Error: " + str)
        }
        debugPrint(error as Any)
        print("===========================\n\n")
    }
    
    private func logError(_ error: Error, response: DataResponse<Data>) {
        print("\n\n===========Error===========")
        print("Error Code: \(error._code)")
        print("Error Messsage: \(error.localizedDescription)")
        if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
            print("Server Error: " + str)
        }
        debugPrint(error as Any)
        print("===========================\n\n")
    }

}

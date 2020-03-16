//
//  AlbumNetworkManager.swift
//  Nike-Coding
//
//  Created by karthik  kumar padala on 3/15/20.
//  Copyright © 2020 Nike. All rights reserved.
//

import Foundation

public class AlbumNetworkManager: Codable {
    
    //APPError enum which shows all possible errors
    enum APPError: Error {
        case networkError(Error)
        case dataNotFound
        case jsonParsingError(Error)
        case invalidStatusCode(Int)
    }

    //Result enum to show success or failure
    enum Result<T> {
        case success(Data)
        case failure(Error)
    }

    //dataRequest which sends request to given URL and convert to Decodable Object
    func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (T?, Error?) -> Void) {

        //create the url with NSURL
        guard let URL = URL(string: url) else { return }
        let dataURL = URL

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else { return }
            do {
                //create decodable object from data
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(decodedObject, nil)
            } catch let error {
                completion(nil, error)
            }
        })

        task.resume()
    }
}

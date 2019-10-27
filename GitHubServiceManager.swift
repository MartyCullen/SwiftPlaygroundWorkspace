//
//  GitHubServiceManager.swift
//  Validic_test
//
//  Created by Marty Cullen on 1/8/18.
//  Copyright © 2018 Marty Cullen. All rights reserved.
//

import Foundation

class GitHubServiceManager {
    
    typealias CitySearchCompletionHandler = (_ jobs: [Job]) -> Void
    
    lazy var urlSession: URLSession = {
        // Configure the `URLSession` instance that is going to be used for making network calls.
        let urlSessionConfiguration = URLSessionConfiguration.default
        
        return URLSession(configuration: urlSessionConfiguration)
    }()

    func getData(forCity city:String, completion: @escaping CitySearchCompletionHandler) {
        //let urlString = "http://jobs.github.com/positions.json?location=new+york"
        let urlString = String(format: "http://jobs.github.com/positions.json?location=%@", city)
        guard let url = URL(string: urlString) else {
            return
        }
        
        
        let urlRequest = URLRequest(url: url)

        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("GitHub returned an error")
                print(error!)
                completion([])
                return
            }
            
            guard let responseData = data else {
                print("No data received from GitHub")
                completion([])
                return
            }
            
            // For debugging response
            //            let responseString = NSString(data: responseData, encoding: String.Encoding.utf8.rawValue)
            //            print(responseString)
            
            do {
                let jobs = try JSONDecoder().decode([Job].self, from: responseData) // New in Swift 4, used to serialize json.
                //print(jobs)
                completion(jobs)
            } catch let error {
                print("Error converting data from GitHub to JSON")
                print(error)
                completion([])
                return
            }
            }.resume()
        
    }

}

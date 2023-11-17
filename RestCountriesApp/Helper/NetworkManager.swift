//
//  Helper.swift
//  RestCountriesApp
//
//  Created by maris.rozenstoks on 17/11/2023.
//

import Foundation

class NetworkManager{
    static func fetchData(url:String,completion: @escaping ([Country]) -> ()){
        
        guard let url = URL(string:url) else {return}
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request){
            (data,response,err) in
            guard err == nil else{
                return
            }
            
            guard let data = data else {return}
            
            do{
                let json = try JSONDecoder().decode([Country].self, from:data)
                completion(json)
            }
            catch{
                return
            }
        }.resume()
        
        
    }
}

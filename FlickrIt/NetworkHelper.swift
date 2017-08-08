//
//  NetworkHelper.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireImage


typealias NetworkResponse = (NetworkResult) -> Void
typealias NetworkImageResponse = (NetworkImageResult) -> Void

enum NetworkResult{
    case success(JSON)
    case failure(Error)
}

enum NetworkImageResult{
    case success(UIImage)
    case failure(Error)
}

struct NetworkHelper{
    
    /**
     Performs a GET request with parameters and returns a NetworkResponse
     
     - Parameters:
        - url: url of the request
        - params: parameters(optional)
        - completion: NetworkResponse
     - Returns:
        NetworkResponse
     */
    
    static func getRequest(url:String,params: [String:String]?, completion: @escaping NetworkResponse){
        
        Alamofire.request(url).validate(statusCode: 200..<300).responseJSON { (response) in
            
            switch response.result {
            case .success:
//                print(response.result.value)
                if let value = response.result.value {
                    let json = JSON(value)
                    completion(.success(json))
                }else{
                    
                }

            case .failure(let error):
                //print(error)
                completion(.failure(error))
            }
        }
    }
    
    /**
     Performs a GET request with url and returns a NetworkImageResponse
     
     - Parameters:
        - url: url of the request
        - completion: NetworkResponse
     - Returns:
        NetworkResponse
     */
    
    static func getImage(url:String, completion: @escaping NetworkImageResponse ){
        Alamofire.request(url).responseImage { response in
            debugPrint(response)
            
//            print(response.request)
//            print(response.response)
//            debugPrint(response.result)
            
            if let image = response.result.value {
//                print("image downloaded: \(image)")
                completion(.success(image))
            }else if let error = response.error{
                completion(.failure(error))
            }
        }
    }
    
    
}

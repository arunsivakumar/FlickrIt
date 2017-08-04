//
//  PhotoStore.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

typealias PhotoCompletion = (PhotoResult) -> Void

enum PhotoResult{
    case success([Photo])
    case failure(Error)
}


class PhotoStore{
    
    
    func fetchInterestingPhotos(completion: @escaping PhotoCompletion){
        
        let url = FlickrAPI.interestingPhotosURL.absoluteString
        
        NetworkHelper.getData(url: url, params: nil) { (result) in
           let result = self.processRequest(for: result)
            completion(result)
        }
      
    }
    
    func searchPhotos(completion: PhotoCompletion){
        
    }
    
    private func processRequest(for result:NetworkResult) -> PhotoResult{
        switch result{
            case .success(let json):
                return FlickrAPI.photos(from: json)
            case .failure(let error):
                return .failure(error)
        }
    }
    
}

//
//  PhotoStore.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import UIKit

typealias PhotoCompletion = (PhotoResult) -> Void
typealias ImageCompletion = (ImageResult) -> Void

enum PhotoResult{
    case success([Photo])
    case failure(Error)
}

enum ImageResult{
    case success(UIImage)
    case failure(Error)
}

class PhotoStore{
    
    
    var imageCache: NSCache<NSString, UIImage>!
    
    init(){
        self.imageCache = NSCache<NSString, UIImage>()
    }
        
    
    func fetchPhotos(completion: @escaping PhotoCompletion){
        let url = FlickrAPI.panoramaPhotosURL.absoluteString
        
        NetworkHelper.getRequest(url: url, params: nil) { (result) in
            let result = self.processRequest(for: result)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
    }

    
    private func processRequest(for result:NetworkResult) -> PhotoResult{
        switch result{
            case .success(let json):
                return FlickrAPI.photos(from: json)
            case .failure(let error):
                return .failure(error)
        }
    }
    
    func fetchImage(for photo:Photo,completion: @escaping ImageCompletion){
        
        if let image = imageCache.object(forKey: photo.url.absoluteString as NSString){
            OperationQueue.main.addOperation {
                completion(.success(image))
            }
        }else{
            
            let photoURLString = photo.url.absoluteString
            
            // download image
            
            NetworkHelper.getImage(url:photoURLString, completion: { (result) in
                 let result = self.processImageRequest(for: result)
                
                //cache image
                
                if case let .success(image) = result {
                    self.imageCache.setObject(image, forKey: photoURLString as NSString)
                }
                OperationQueue.main.addOperation {
                    completion(result)
                }

            })
        }
        
    }
    
    private func processImageRequest(for result:NetworkImageResult) -> ImageResult{
        switch result{
        case .success(let image):
            return .success(image)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    
    
}

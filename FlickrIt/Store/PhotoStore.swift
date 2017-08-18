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



/**
 
 Photos result from API
 
 - success: Array of photos
 - failure: Error (Data task Error, JSON processing error )
 
 */

enum PhotoResult{
    case success([Photo]) // Photos, page, pages, perpage, total
    case failure(Error)
}

/**
 
 Downloaded Photo from URL
 
 - success: UIImage
 - failure: Error
 
 */

enum ImageResult{
    case success(UIImage)
    case failure(Error)
}



class PhotoStore{
    
    
    let photos = [[Photo]]()
    
    var imageCache: NSCache<NSString, UIImage>!
    
    init(){
        self.imageCache = NSCache<NSString, UIImage>()
    }
    
    
    /**
     Fetches photos by Connecting to api.flickr.com.
     
     - Parameters:
        - completion: PhotosResult.
     
     - Returns:
        Void
     */
    
    
    func fetchPhotos(completion: @escaping PhotoCompletion){
        let url = FlickrAPI.panoromaPhotosURL().absoluteString
        
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
    
    /**
     Fetches photo from image cache or download from network based on url
     
     - Parameters:
        - photo: Photo
        - completion: ImageCompletion
     
     - Returns: ImageCompletion
     */
    
     //FIXME:- the completion block doesnt get dispatched on the main thread
    
    func fetchImage(for photo:Photo,completion: @escaping ImageCompletion){
        
        // fetch from cache
        if let image = imageCache.object(forKey: photo.url.absoluteString as NSString){
            OperationQueue.main.addOperation {
                completion(.success(image))
            }
        }else{
            
            let photoURLString = photo.url.absoluteString
            
            // download image from network
            
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
    
    /**
     Fetches photos by Connecting to api.flickr.com.
     
     - Parameters:
        - for: NetworkImageResult
     
     - Returns: ImageResult
     
     */
    
    
    private func processImageRequest(for result:NetworkImageResult) -> ImageResult{
        switch result{
        case .success(let image):
            return .success(image)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func targetWillDisplay(section:Int,row: Int){
        if photos.count == section - 1 && photos[section].count == row - 1{
            
        }
        
    }
    
    
    
}

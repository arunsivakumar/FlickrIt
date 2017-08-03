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
import SwiftyJSON

typealias PhotoCompletion = (PhotoResult) -> Void

enum PhotoResult{
    case success([Photo])
    case failure(Error)
}
class PhotoStore{
    
    
    func fetchInterestingPhotos(completion: PhotoCompletion){
        
    }
    
    func searchPhotos(completion: PhotoCompletion){
        
    }
    
}

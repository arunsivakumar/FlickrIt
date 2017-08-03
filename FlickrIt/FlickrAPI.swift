//
//  FlickrAPI.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation



/// A FlickrAPI constructor
struct FlickrAPI{
    
    private static let baseURLString =  "https://api.flickr.com/services/rest"
    private static let apiKey = "fd3c0d32acfaca425895462a4194ee13"

    private static func createURL() -> URL{
        
        return URL
    }
    
    static var interestingPhotosURL:URL{
       return createURL()
    }

}

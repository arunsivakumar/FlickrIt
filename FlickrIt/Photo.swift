//
//  Photo.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import Bond


class Photo{
    
    var id: String
    var url: URL
    var title: String
    
    
    /**
     Designated Initializer
     
     - Parameters:
        - id: photo id.
        - title: photo title
        - url: photo URL
     
     - Returns:
        Void
     */
    
    
    init(id: String, title: String, url: URL){
        
        self.id = id
        self.url = url
        self.title = title
    }
    
}

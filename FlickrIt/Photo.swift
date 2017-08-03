//
//  Photo.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation


class Photo{
    
    var dateTaken: Date
    var id: String
    var url: URL
    var title: String
    
    
    init(id: String, url: URL, title: String, dateTaken: Data){
        
        self.id = id
        self.url = url
        self. title = title
        self.dateTaken = dateTaken
    }
    
}

//
//  FlickrAPI.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import Foundation
import SwiftyJSON

//sample request
//https://api.flickr.com/services/rest/?method=flickr.test.echo&name=value

// Arguments
/**
api_key (Required)
Your API application key. See here for more details.
    date (Optional)
A specific date, formatted as YYYY-MM-DD, to return interesting photos for.
extras (Optional)
A comma-delimited list of extra information to fetch for each returned record. Currently supported fields are: description, license, date_upload, date_taken, owner_name, icon_server, original_format, last_update, geo, tags, machine_tags, o_dims, views, media, path_alias, url_sq, url_t, url_s, url_q, url_m, url_n, url_z, url_c, url_l, url_o
per_page (Optional)
Number of photos to return per page. If this argument is omitted, it defaults to 100. The maximum allowed value is 500.
page (Optional)
The page of results to return. If this argument is omitted, it defaults to 1.
*/

enum FlickrError: Error{
    case processingJSON
}

enum FlickrMethod:String{
    case interestingPhotos = "flickr.interestingness.getList"
    case panaromicPhotos = "flickr.photos.search"
}

/// A FlickrAPI constructor
struct FlickrAPI{
    
    private static let baseURLString =  "https://api.flickr.com/services/rest"
    private static let apiKey = "fd3c0d32acfaca425895462a4194ee13"
    
    private static let valuePanaroma       = "panaroma"
    
    private static let keyExtras           = "extras"
    private static let keyTags             = "tags"
    
    private static let keyMethod           = "method"
    
    private static let keyFormat           = "format"
    private static let valueFormat         = "json"
    
    private static let keyNoJSONCallBack   = "nojsoncallback"
    private static let ValueNoJSONCallBack = "1"
    
    private static let keyAPI              = "api_key"

    
    private static func constructURL(flickrMethod:FlickrMethod, parameters:[String:String]?) -> URL{
        
        var components = URLComponents(string:baseURLString)!
        
        var queryItems = [URLQueryItem]()
        
        let baseParameters = [
            keyMethod: flickrMethod.rawValue,
            keyFormat: valueFormat,
            keyNoJSONCallBack: ValueNoJSONCallBack,
            keyAPI: apiKey
        ]
        
        for (key, value) in baseParameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let parameters = parameters{
            for(key,value) in parameters{
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }

        components.queryItems = queryItems
        
        return components.url!
    }
    
    static var panoramaPhotosURL: URL{
        return constructURL(flickrMethod: .panaromicPhotos, parameters: [keyExtras:valueUrl,keyTags:valuePanaroma])
    }
    
    
    private static let valuePhotos         = "photos"
    private static let valuePhoto          = "photo"
    private static let valueId             = "id"
    private static let valueTitle          = "title"
    private static let valueDateTaken      = "datetaken"
    private static let valueUrl            = "url_h"

    static func photos(from json: JSON) -> PhotoResult{
        
        var photoItems = [Photo]()
        
        guard
            let photos = json[valuePhotos].dictionary,
            let photoArray = photos[valuePhoto]?.array else{
                
            return .failure(FlickrError.processingJSON)
        }
        
        for photoJSON in photoArray{
            if let photo = photo(from: photoJSON){
                photoItems.append(photo)
            }else{
                // invalid json
            }
        }
        
        // check if JSON processing failed completely
        
        return .success(photoItems)
    }
    
    private static func photo(from json:JSON) -> Photo?{
        guard
            let id = json[valueId].string,
            let title = json[valueTitle].string,
            let urlString = json[valueUrl].string,
            let url = URL(string:urlString) else{
                
                // Information is not enough to construct a photo
                return nil
        }
        return Photo(id: id, title: title, url: url)
    }

}

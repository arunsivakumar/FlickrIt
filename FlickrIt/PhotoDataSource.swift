//
//  PhotoDataSource.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit


class PhotoDataSource:NSObject,UICollectionViewDataSource{
    var photos = [Photo]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let identifier = "PhotoCollectionViewCell"
        
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                               for: indexPath) as! UICollectionViewCell
        return cell
        
    }
}


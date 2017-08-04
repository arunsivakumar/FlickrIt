//
//  PhotoCollectionViewCell.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell{
    
    var photo:Photo?{
        didSet{
            if let photo = photo{
                
                
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

}

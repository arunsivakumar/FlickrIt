//
//  PhotoCollectionViewCell.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var photoImageView: UIImageView!
    var photo:Photo?{
        didSet{
            if let photo = photo{
       
                photoImageView.kf.setImage(with: photo.url)
                
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

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
    
      //MARK:- Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK:- Variables
    var photo:Photo?{
        didSet{
            if let photo = photo{
       
                photoImageView.kf.setImage(with: photo.url)
                
            }
        }
    }
    
    //MARK:- View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

}

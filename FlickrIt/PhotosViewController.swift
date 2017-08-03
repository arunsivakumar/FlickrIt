//
//  ViewController.swift
//  FlickrIt
//
//  Created by Lakshmi on 8/3/17.
//  Copyright © 2017 com.arunsivakumar. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    var photoStore:PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = photoDataSource
        
        loadData()
    }
    
    
    func loadData(){
        photoStore.fetchInterestingPhotos { (photoResult) in
            switch photoResult{
                case let .success(photos):
                    self.photoDataSource.photos = photos
                case .failure(_):
                    self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer:0))
        }
        
    }
}

extension PhotosViewController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
    }
}

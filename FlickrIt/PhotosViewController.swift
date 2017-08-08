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
        photoStore.fetchPhotos { (photoResult) in
            switch photoResult{
                case let .success(photos):
                    self.photoDataSource.photos = photos
                case .failure(_):
                    self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadData()
        }
        
    }
}

extension PhotosViewController:UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cells = 1
        let width = (self.view.frame.width / CGFloat(cells))
        let height = width / 3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let photo = photoDataSource.photos[indexPath.row]
//    }
}

extension PhotosViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto"?:
            if let selectedIndexPath =
                collectionView.indexPathsForSelectedItems?.first {
                
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let vc =
                    segue.destination as! PhotoDetailViewController
                vc.photo = photo
                vc.photoStore = photoStore
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }

}

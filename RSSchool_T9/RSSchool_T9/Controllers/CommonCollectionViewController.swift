//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Liza Kryshkovskaya
// On: 28.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class CommonCollectionViewController: UIViewController {
    
    var myCollectionView:UICollectionView?
    
    let numberOfItemsPerRow: CGFloat = 2.0
    let screenSize: CGRect = UIScreen.main.bounds
    
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    var items: [ContentType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        items = FillingData.data

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //layout.itemSize = CGSize(width: 179, height: 220)
            
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(myCollectionView!)
        
        myCollectionView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        myCollectionView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        myCollectionView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        myCollectionView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

        
        
        
        myCollectionView?.register(ItemsCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
        myCollectionView?.backgroundColor = UIColor.white
        
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        
        self.view.addSubview(myCollectionView ?? UICollectionView())
        
    }
    
}



extension CommonCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // сначала нужно получить ячейку и привести ее к типу, который мы создали для ячейки
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemsCollectionViewCell
        
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 8, y: 10), size: CGSize(width: cell.bounds.width-16, height: cell.bounds.height-20)))
        
        cell.imageView = imageView
            
        switch items[indexPath.row] {
                case .story(let story):
                    imageView.image = story.coverImage
                    
                case .gallery(let gallery):
                    imageView.image = gallery.coverImage
        }
        cell.addSubview(imageView)
        cell.setUpView()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            let width = (screenSize.width-56)/numberOfItemsPerRow
            return CGSize(width: width, height: width/0.81)
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row)")
    }
}

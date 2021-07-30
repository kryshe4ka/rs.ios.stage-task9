//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Liza Kryshkovskaya
// On: 29.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ItemsCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    var view: UIView?
    var title: UILabel?
    var type: UILabel?
    
    func setUpView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 18
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.imageView?.layer.borderWidth = 1
        self.imageView?.layer.borderColor = UIColor.black.cgColor
        self.imageView?.layer.cornerRadius = 10
        self.imageView?.clipsToBounds = true
        self.imageView?.contentMode = .scaleAspectFill
    }
    
}

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
    var title: UILabel = {
        let v = UILabel()
        v.textColor = .white
        v.font = UIFont(name: "Rockwell-Regular", size: 16)
        v.lineBreakMode = .byTruncatingTail
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer();
        gradient.colors = [
                    UIColor(named: "gr1")!.cgColor,
                    UIColor(named: "gr2")!.cgColor,
                ];
            
            gradient.locations = [0.64, 1];
            
            return gradient;
        }()
    
    var typeLabel:UILabel = {
            let v = UILabel();
            v.font = UIFont(name: "Rockwell-Regular", size: 12);
            v.textColor = UIColor(named: "B6B6B6")
        v.translatesAutoresizingMaskIntoConstraints = false

            return v;
        }()
    
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
        
        self.imageView?.layer.insertSublayer(self.gradientLayer, at: 0)
        
        self.addSubview(title)
        self.addSubview(typeLabel)
        
        
    }
    
    override func layoutSubviews() {
            super.layoutSubviews();
            
            self.gradientLayer.frame = self.bounds;
            
//            let titleLabelNewFrame = CGRect(x: self.titleLabel.frame.origin.x, y: self.titleLabel.frame.origin.y, width: self.titleLabel.frame.size.width, height: self.titleLabel.frame.size.height + 5);
//            self.titleLabel.frame = titleLabelNewFrame;
            
//            let subtitleLabelNewFrame = CGRect(x: self.subtitleLabel.frame.origin.x, y: self.subtitleLabel.frame.origin.y, width: self.subtitleLabel.frame.size.width, height: self.subtitleLabel.frame.size.height + 5);
//            self.subtitleLabel.frame = subtitleLabelNewFrame;
        }
    
}

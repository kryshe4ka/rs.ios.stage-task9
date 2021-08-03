//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Liza Kryshkovskaya
// On: 30.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class CloseButton: UIButton {
    //let screenSize: CGRect = UIScreen.main.bounds

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        //self.setTitle("X", for: .normal)
       // self.setTitleColor(.white, for: .normal)
        self.backgroundColor = .black
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        if let image = UIImage(named: "xmark-2.png") {
            self.setImage(image, for: .normal)
        }
        if let image = UIImage(named: "xmark-3.png") {
            
            self.setImage(image, for: .highlighted)
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

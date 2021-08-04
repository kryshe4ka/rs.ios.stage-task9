// Project: RSSchool_T9
// 
// Author: Liza Kryshkovskaya
// On: 2.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ZoomViewController: UIViewController, UIScrollViewDelegate {
    var item = UIImageView()

    let closeButton: CloseButton = {
        let v = CloseButton.init()
        v.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        return v
    }()
    
    let imageView: UIImageView = {
        let v = UIImageView(frame: CGRect.zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        v.backgroundColor = .black
        return v
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentInsetAdjustmentBehavior = .never
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        v.minimumZoomScale = 1
        v.maximumZoomScale = 3
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        scrollView.delegate = self
        imageView.image = item.image
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        scrollView.addSubview(imageView)
        
        // constrain scrollview
        scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.frameLayoutGuide.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.frameLayoutGuide.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor).isActive = true
        scrollView.contentLayoutGuide.leftAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leftAnchor).isActive = true
        scrollView.contentLayoutGuide.rightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.rightAnchor).isActive = true
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor).isActive = true

        // constrain imageView
        imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        
        // constrain close button
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapHandle(_:)))
        self.view.addGestureRecognizer(tap)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return self.imageView
    }
    
    // кнопка закрыть
    @objc func closeButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.25) { [self] in
            view.frame = CGRect(x: 0, y: view.bounds.size.height, width: view.bounds.size.width, height: view.bounds.size.height)
        } completion: { _ in
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    @objc func tapHandle(_ sender: UITapGestureRecognizer) {
        self.closeButton.isHidden = !self.closeButton.isHidden
    }
}

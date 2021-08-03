//
// 📰 🐸 
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
        v.contentMode = .scaleAspectFill
        v.backgroundColor = .yellow
        return v
    }()
    let scrollView: UIScrollView = {
        //let v = UIScrollView()
        let v = UIScrollView(frame: UIScreen.main.bounds)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // Zooming
        scrollView.minimumZoomScale = 0.5;
        scrollView.maximumZoomScale = 3;
        imageView.image = item.image
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        
        imageView.bounds = CGRect(x: 0, y: 0, width: item.image!.size.width, height: item.image!.size.height)
        
        scrollView.contentSize = imageView.frame.size;
        scrollView.delegate = self
        
        view.addSubview(scrollView)

        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true

        // add imageView to view
        scrollView.addSubview(imageView)
        imageView.backgroundColor = .red
        // constrain imageView
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 172).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -172).isActive = true
        imageView.isUserInteractionEnabled = true
        
        
        
        //scrollView.contentSize = imageView.bounds.size
    //    scrollView.showsVerticalScrollIndicator = false
      //  scrollView.showsHorizontalScrollIndicator = false
        

        
        // add close button to view
        view.addSubview(closeButton)
        // constrain close button
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapHandle(_:)))
        self.view.addGestureRecognizer(tap)
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {

        return self.imageView
        

    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        return
    }
    
    // кнопка закрыть
    @objc func closeButtonTapped(_ sender: Any) {
        //delegate.timerDidPick(value: stepper.value)
        //self.tabBarController?.tabBar.isHidden = false
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

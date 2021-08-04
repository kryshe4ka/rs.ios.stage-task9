//// Project: RSSchool_T9
////
//// Author: Liza Kryshkovskaya
//// On: 30.07.21
////
//// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class StoryViewController : UIViewController {
    
    var drawOFF = false
    var strokeColor = UIColor(named: "f3af22")?.cgColor
    var item: ContentType?
    var numberOfImages = 0
    
    private var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer();
        gradient.colors = [
            UIColor(named: "gr1")!.cgColor,
            UIColor(named: "gr2")!.cgColor,
        ];
        gradient.locations = [0.64, 1];
        return gradient;
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        return v
    }()

    let imageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.white.cgColor
        return v
    }()
    
    let typeLabel: TypeLabel = {
        let v = TypeLabel(frame: CGRect.zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.borderWidth = 1
        v.layer.cornerRadius = 8
        v.textAlignment = .center
        v.textColor = .white
        v.font = UIFont.init(name: "Rockwell", size: 24)
        v.backgroundColor = .black
        v.clipsToBounds = true
       return v
    }()
    
    let closeButton: CloseButton = {
        let v = CloseButton.init()
        v.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        return v
    }()
    
    let lineView: UIView = {
        let v = UIView(frame: CGRect.zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    let storyView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.borderWidth = 1
        v.layer.cornerRadius = 8
        v.clipsToBounds = true
       return v
    }()
    let storyLabel: UILabel = {
        let v = UILabel()
        v.numberOfLines = 0
        v.textColor = .white
        v.font = UIFont.init(name: "Rockwell", size: 24)
        v.sizeToFit()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let pathScrollView:  UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let galleryStackView: UIStackView = {
        let v = UIStackView()
        v.axis = NSLayoutConstraint.Axis.vertical
        v.distribution = .equalCentering
        v.spacing = 20.0
        v.alignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // add the scroll view to self.view
        self.view.addSubview(scrollView)
        // constrain the scroll view
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        // add close button to scroll view
        scrollView.addSubview(closeButton)
        // constrain close button
        closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -25).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        // add imageView to the scroll view
        scrollView.addSubview(imageView)
        imageView.layer.insertSublayer(gradientLayer, at: 0)
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width-40),
            imageView.heightAnchor.constraint(equalToConstant: (view.frame.width - 40)/0.748)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)

        // add typeLabel to the scroll view
        scrollView.addSubview(typeLabel)
        // constrain typeLabel
        let typeLabelConstraints = [
            typeLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            typeLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            typeLabel.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(typeLabelConstraints)
        
        // add line view
        scrollView.addSubview(lineView)
        // constrain line view
        let lineViewConstraints = [
            lineView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 58),
            lineView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 214),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ]
        NSLayoutConstraint.activate(lineViewConstraints)
        
        switch item {
        case .story(let story):
            imageView.image = story.coverImage
            typeLabel.text = "Story"
            storyLabel.text = story.text
            galleryStackView.isHidden = true
            
            // add storyView
            scrollView.addSubview(storyView)
            
            let storyViewConstraints = [
                storyView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 180),
                storyView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                storyView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
                storyView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30)
            ]
            NSLayoutConstraint.activate(storyViewConstraints)
            
            // add storyLabel
            storyView.addSubview(storyLabel)
            // constrain storyLabel
            let storyLabelConstraints = [
                storyLabel.topAnchor.constraint(equalTo: storyView.topAnchor, constant: 30),
                storyLabel.leadingAnchor.constraint(equalTo: storyView.leadingAnchor, constant: 30),
                storyLabel.trailingAnchor.constraint(equalTo: storyView.trailingAnchor, constant: -40),
                storyLabel.bottomAnchor.constraint(equalTo: storyView.bottomAnchor, constant: -30)
            ]
            NSLayoutConstraint.activate(storyLabelConstraints)
        
            // add path scroll view
            scrollView.addSubview(pathScrollView)
            // add constraints
            let pathScrollViewConstraints = [

                pathScrollView.topAnchor.constraint(equalTo: lineView.topAnchor, constant: 40),
                pathScrollView.heightAnchor.constraint(equalToConstant: 100),
                pathScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                pathScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            ]
            NSLayoutConstraint.activate(pathScrollViewConstraints)
            var g = 0
            for path in story.paths {
                let drawView = UIView()
                drawView.translatesAutoresizingMaskIntoConstraints = false
                drawView.animateLinesWithColor(lineColor: strokeColor!, lineWidth: 1.0, duration: 3.0, path: path, drawOFF: drawOFF)
                pathScrollView.addSubview(drawView)
                let drawViewConstraints = [
                    drawView.topAnchor.constraint(equalTo: pathScrollView.topAnchor, constant: 12),
                    drawView.heightAnchor.constraint(equalToConstant: 75),
                    drawView.leadingAnchor.constraint(equalTo: pathScrollView.leadingAnchor, constant: CGFloat(g+50)),
                    drawView.widthAnchor.constraint(equalToConstant: 75),
                ]
                NSLayoutConstraint.activate(drawViewConstraints)
                g += 175
            }
            let pathViewConstraints = [
                pathScrollView.subviews.last!.trailingAnchor.constraint(equalTo: pathScrollView.trailingAnchor, constant: -20),
            ]
            NSLayoutConstraint.activate(pathViewConstraints)
         
        case .gallery(let gallery):
            imageView.image = gallery.coverImage
            typeLabel.text = "Gallery"
            storyView.isHidden = true
            numberOfImages = gallery.images.count
            print(numberOfImages)
                        
            for image in gallery.images {
                
                let galleryImageView = UIView()
                galleryImageView.layer.borderWidth = 1
                galleryImageView.layer.borderColor = UIColor.white.cgColor
                galleryImageView.layer.cornerRadius = 8
                galleryImageView.translatesAutoresizingMaskIntoConstraints = false
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.openZoomView(_:)))
                galleryImageView.addGestureRecognizer(tap)
                
                let galleryImage = UIImageView()
                galleryImage.image = image
                galleryImageView.addSubview(galleryImage)
                galleryImage.contentMode = .scaleAspectFill
                galleryImage.layer.cornerRadius = 8
                galleryImage.clipsToBounds = true
                galleryImage.translatesAutoresizingMaskIntoConstraints = false
                galleryImageView.addSubview(galleryImage)
            
                // constraints
                let galleryImageConstraints = [
                    galleryImage.topAnchor.constraint(equalTo: galleryImageView.topAnchor, constant:10),
                    galleryImage.leadingAnchor.constraint(equalTo: galleryImageView.leadingAnchor, constant:10),
                    galleryImage.trailingAnchor.constraint(equalTo: galleryImageView.trailingAnchor, constant:-10),
                    galleryImage.bottomAnchor.constraint(equalTo: galleryImageView.bottomAnchor, constant:-10)
                ]
                NSLayoutConstraint.activate(galleryImageConstraints)
                galleryStackView.addSubview(galleryImageView)
                // constraints
                let galleryImageViewConstraints = [
                    galleryImageView.heightAnchor.constraint(equalToConstant: 511),
                    galleryImageView.leadingAnchor.constraint(equalTo: galleryStackView.leadingAnchor),
                    galleryImageView.trailingAnchor.constraint(equalTo: galleryStackView.trailingAnchor),
                ]
                NSLayoutConstraint.activate(galleryImageViewConstraints)
            }
            
            let testConst2 = [
                galleryStackView.subviews.first!.topAnchor.constraint(equalTo: galleryStackView.topAnchor, constant: 10),
            ]
            NSLayoutConstraint.activate(testConst2)
            
            for i in 0..<(numberOfImages-1) {
                let testConst = [
                    galleryStackView.subviews[i].bottomAnchor.constraint(equalTo: galleryStackView.subviews[i+1].topAnchor, constant: -20)
                ]
                NSLayoutConstraint.activate(testConst)
            }
            
            let height = numberOfImages * 511
            scrollView.addSubview(galleryStackView)
            
            // constrain
            let galleryStackViewConstraints = [
                galleryStackView.topAnchor.constraint(equalTo: lineView.topAnchor, constant: 40),
                galleryStackView.heightAnchor.constraint(equalToConstant: CGFloat(height)),
                galleryStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                galleryStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
                galleryStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -70)
            ]
            NSLayoutConstraint.activate(galleryStackViewConstraints)
            
        case .none:
            print("NONE")
        }
    }
    
    // кнопка закрыть
    @objc func closeButtonTapped(_ sender: Any) {
        //delegate.timerDidPick(value: stepper.value)
        self.tabBarController?.tabBar.isHidden = false
        UIView.animate(withDuration: 0.25) { [self] in
            view.frame = CGRect(x: 0, y: view.bounds.size.height, width: view.bounds.size.width, height: view.bounds.size.height)
        } completion: { _ in
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    @objc func openZoomView(_ sender: UITapGestureRecognizer) {
        let zoomVC = ZoomViewController()
        print(sender.view!.subviews.first!)
        zoomVC.item = sender.view!.subviews.first! as! UIImageView
        self.addChild(zoomVC)
        self.view.addSubview(zoomVC.view)
        zoomVC.didMove(toParent: self)
    }
}

extension UIView {
    func animateLinesWithColor(lineColor: CGColor, lineWidth: CGFloat, duration:CGFloat, path: CGPath, drawOFF: Bool ) {
        let animateLayer = CAShapeLayer(layer: layer)
        animateLayer.lineCap = CAShapeLayerLineCap.round
        animateLayer.lineJoin = .bevel
        animateLayer.fillColor = UIColor.clear.cgColor
        animateLayer.lineWidth = lineWidth
        animateLayer.strokeEnd = 0.0
        
        animateLayer.path = path
        animateLayer.strokeColor = lineColor
        self.layer.addSublayer(animateLayer)
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 3.0
        pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        pathAnimation.autoreverses = false;
        
        // вкл/выкл анимацию
        if drawOFF {
            animateLayer.add(pathAnimation, forKey: "strokeEndAnimation")
        }
        animateLayer.strokeEnd = 1.0
    }
}

//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Liza Kryshkovskaya
// On: 28.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class CommonCollectionViewController: UIViewController, SwitcherDelegate, ColorDelegate {
    var drawOFF = true
    var strokeColor = UIColor.init(fromHexFormat: "#92003b")
    
    func setSwitcher(_ drawOff: Bool) {
        self.drawOFF = drawOff
    }
    func setColor(_ strokeColor: String) {
        self.strokeColor = UIColor.init(fromHexFormat: strokeColor)
    }

    var myCollectionView:UICollectionView?
    
    let numberOfItemsPerRow: CGFloat = 2.0
    let screenSize: CGRect = UIScreen.main.bounds
    
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    var items: [ContentType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // прячем навигейшн бар
        self.navigationController?.isNavigationBarHidden = true
        items = FillingData.data
        
        self.navigationController?.navigationBar.tintColor = .red

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(myCollectionView!)
        
        // настраиваем констрейнты
        myCollectionView?.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        myCollectionView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        myCollectionView?.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        myCollectionView?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        // регистрируем ячейку
        myCollectionView?.register(ItemsCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
        
        // цвет фона коллекции
        myCollectionView?.backgroundColor = UIColor.white
        // делегаты
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
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
                    cell.title.text = story.title
                    cell.typeLabel.text = story.type
                    
                case .gallery(let gallery):
                    imageView.image = gallery.coverImage
                    cell.title.text = gallery.title
                    cell.typeLabel.text = gallery.type
        }
        cell.addSubview(imageView)
        cell.setUpView()
        
        cell.title.heightAnchor.constraint(equalToConstant: 19).isActive = true
        cell.title.trailingAnchor.constraint(equalTo: cell.imageView!.trailingAnchor, constant: -15).isActive = true
        cell.title.bottomAnchor.constraint(equalTo: cell.imageView!.bottomAnchor, constant: -30).isActive = true
        cell.title.leadingAnchor.constraint(equalTo: cell.imageView!.leadingAnchor, constant: 10).isActive = true
        
        cell.typeLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        cell.typeLabel.trailingAnchor.constraint(equalTo: cell.imageView!.trailingAnchor, constant: -15).isActive = true
        cell.typeLabel.bottomAnchor.constraint(equalTo: cell.imageView!.bottomAnchor, constant: -13).isActive = true
        cell.typeLabel.leadingAnchor.constraint(equalTo: cell.imageView!.leadingAnchor, constant: 10).isActive = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            let width = (screenSize.width-56)/numberOfItemsPerRow
            return CGSize(width: width, height: width/0.81)
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyVC = StoryViewController()
        storyVC.item = items[indexPath.row]
        storyVC.drawOFF = self.drawOFF
        storyVC.strokeColor = self.strokeColor.cgColor
        self.addChild(storyVC)
        self.view.addSubview(storyVC.view)
        storyVC.didMove(toParent: self)
        self.tabBarController?.tabBar.isHidden = true
    }
}

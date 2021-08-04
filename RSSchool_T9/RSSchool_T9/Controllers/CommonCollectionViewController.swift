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
    let numberOfItemsPerRow: CGFloat = 2.0
    var items: [ContentType] = []
    
    private lazy var myCollectionView: UICollectionView = {
        let v = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        // регистрируем ячейку
        v.register(ItemsCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
        v.dataSource = self
        v.delegate = self
        v.translatesAutoresizingMaskIntoConstraints = false
        v.showsVerticalScrollIndicator = false
        v.backgroundColor = .clear
        v.showsVerticalScrollIndicator = false
        // цвет фона коллекции
        v.backgroundColor = UIColor.white
        // делегаты
        v.dataSource = self
        v.delegate = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true  // прячем навигейшн бар
        items = FillingData.data
        self.navigationController?.navigationBar.tintColor = .red
        self.view.addSubview(myCollectionView)
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            myCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            myCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            myCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
    
    func setSwitcher(_ drawOff: Bool) {
        self.drawOFF = drawOff
    }
    
    func setColor(_ strokeColor: String) {
        self.strokeColor = UIColor.init(fromHexFormat: strokeColor)
    }
}

extension CommonCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // сначала нужно получить ячейку и привести ее к типу, который мы создали для ячейки
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemsCollectionViewCell
     
        switch items[indexPath.row] {
                case .story(let story):
                    cell.imageView.image = story.coverImage
                    cell.title.text = story.title
                    cell.typeLabel.text = story.type
                    
                case .gallery(let gallery):
                    cell.imageView.image = gallery.coverImage
                    cell.title.text = gallery.title
                    cell.typeLabel.text = gallery.type
        }
        
        cell.addSubview(cell.imageView)
        cell.setUpView()
        
        cell.imageView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10).isActive = true
        cell.imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 8).isActive = true
        cell.imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -8).isActive = true
        cell.imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -10).isActive = true
          
        cell.title.heightAnchor.constraint(equalToConstant: 19).isActive = true
        cell.title.trailingAnchor.constraint(equalTo: cell.imageView.trailingAnchor, constant: -15).isActive = true
        cell.title.bottomAnchor.constraint(equalTo: cell.imageView.bottomAnchor, constant: -30).isActive = true
        cell.title.leadingAnchor.constraint(equalTo: cell.imageView.leadingAnchor, constant: 10).isActive = true
        
        cell.typeLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        cell.typeLabel.trailingAnchor.constraint(equalTo: cell.imageView.trailingAnchor, constant: -15).isActive = true
        cell.typeLabel.bottomAnchor.constraint(equalTo: cell.imageView.bottomAnchor, constant: -13).isActive = true
        cell.typeLabel.leadingAnchor.constraint(equalTo: cell.imageView.leadingAnchor, constant: 10).isActive = true
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let storyVC = StoryViewController()
        storyVC.item = items[indexPath.row]
        storyVC.drawOFF = self.drawOFF
        storyVC.strokeColor = self.strokeColor.cgColor
        self.addChild(storyVC)
        self.view.addSubview(storyVC.view)
        storyVC.didMove(toParent: self)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (UIScreen.main.bounds.width-56)/numberOfItemsPerRow
        return CGSize(width: width, height: width/0.81)
    }
        
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
   {
        return UIEdgeInsets(top: 0, left: CGFloat(20), bottom: 40, right: CGFloat(20))
   }
}

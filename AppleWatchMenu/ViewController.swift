//
//  Menu.swift
//  AppleWatchMenu
//
//  Created by Patryk Adamkiewicz on 16/11/14.
//  Copyright (c) 2014 Patryk Adamkiewicz. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class ViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    var numberOfItems:Int = 0
    var collectionView = MenuCollectionView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.addSubview(UIImageView(image: UIImage(named: "background")!))
        
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerClass(MenuCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.view.addSubview(self.collectionView)
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[collection]|", options: nil, metrics: nil, views: ["collection":collectionView]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[collection]|", options: nil, metrics: nil, views: ["collection":collectionView]))
    }
    
    override func viewDidAppear(animated: Bool)
    {
        self.numberOfItems = 127;
        self.collectionView.centerContentWithItemCount(self.numberOfItems)
        
        var indexPaths:[NSIndexPath] = []
        for index in 0..<self.numberOfItems {
            indexPaths.append(NSIndexPath(forItem: index, inSection: 0))
        }
        self.collectionView.insertItemsAtIndexPaths(indexPaths)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.numberOfItems
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as MenuCell
        cell.icon.image = UIImage(named: "RoundIcons-Free-Set-\(indexPath.row % 61 + 1)")
        return cell
    }
}

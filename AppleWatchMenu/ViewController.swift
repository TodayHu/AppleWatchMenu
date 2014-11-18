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
        self.collectionView.centerContent()
        self.numberOfItems = 127;
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
        
        cell.icon.image = UIImage(named: "RoundIcons-Free-Set-\((indexPath.row+1) % 61)")
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

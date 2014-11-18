//
//  MenuItem.swift
//  AppleWatchMenu
//
//  Created by Patryk Adamkiewicz on 16/11/14.
//  Copyright (c) 2014 Patryk Adamkiewicz. All rights reserved.
//

import UIKit

class MenuCollectionView: UICollectionView
{
    var layout = MenuLayout(coder: NSCoder())
    
    override init()
    {
        super.init(frame: CGRectZero, collectionViewLayout: self.layout)
        self.backgroundColor = UIColor.whiteColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup()
    {
        print("setup")
    }
    
    func centerContent()
    {
        let offsetX = (self.contentSize.width - self.bounds.size.width) / 2.0
        let offsetY = (self.contentSize.height - self.bounds.size.height) / 2.0
        self.contentOffset = CGPointMake(offsetX, offsetY);
    }
    
    func contentCenter() -> CGPoint
    {
        return CGPointMake(self.contentSize.width/2, self.contentSize.height/2)
    }

}

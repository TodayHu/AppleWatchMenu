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
    var gesture: UIPinchGestureRecognizer?
    var scale: CGFloat = 1.0
    var intermediateScale: CGFloat = 1.0
    var contentMidPoint: CGPoint = CGPointZero
    
    override init()
    {
        super.init(frame: CGRectZero, collectionViewLayout: self.layout)
        self.gesture = UIPinchGestureRecognizer(target: self, action: "handlePinch:")
        self.addGestureRecognizer(self.gesture!)
    }

    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    func setInsets()
    {
        let insetSize = CGSizeMake(CGFloat(self.frame.size.width / 2.0), CGFloat(self.frame.size.height / 2.0))
        self.contentInset = UIEdgeInsets(top: insetSize.height, left: insetSize.width, bottom: insetSize.height, right: insetSize.width)
    }
    
    func centerContentWithItemCount(count: Int)
    {
        let baseSize = self.layout.collectionBaseContentSizeWithItemCount(count)
        let offsetX = (baseSize.width - self.frame.size.width) / 2
        let offsetY = (baseSize.height - self.frame.size.height) / 2
        self.contentOffset = CGPointMake(offsetX, offsetY);
    }
    
    func contentCenter() -> CGPoint
    {
        return CGPointMake(self.contentSize.width/2, self.contentSize.height/2)
    }
    
    func handlePinch(gesture: UIPinchGestureRecognizer)
    {
        if (gesture.state == .Began) {
            self.intermediateScale = self.scale;
            self.contentMidPoint = CGPointMake(self.contentOffset.x + self.frame.size.width/2, self.contentOffset.y + self.frame.size.height/2)
        }
        else if (gesture.state == .Changed) {
            var newScale = self.intermediateScale * gesture.scale;
            
            if (newScale > 0.5 && newScale < 1.6) {
                self.scale = newScale
                self.contentOffset.x = self.contentMidPoint.x * gesture.scale - self.frame.size.width/2
                self.contentOffset.y = self.contentMidPoint.y * gesture.scale - self.frame.size.height/2
                self.collectionViewLayout.invalidateLayout()
            }
        }
    }
}

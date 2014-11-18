//
//  MenuCollectionViewLayout.swift
//  AppleWatchMenu
//
//  Created by Patryk Adamkiewicz on 16/11/14.
//  Copyright (c) 2014 Patryk Adamkiewicz. All rights reserved.
//

import UIKit

class MenuLayout: UICollectionViewLayout
{
    let itemSize = CGSizeMake(64, 64)
    var contentSize = CGSizeZero
    
    required init(coder aDecoder: NSCoder)
    {
        super.init()
    }
    
    override func collectionViewContentSize() -> CGSize
    {
        if let collection = self.collectionView as? MenuCollectionView {
            let scale = self.collectionScale()
            let baseSize = self.collectionBaseContentSizeWithItemCount(self.collectionView!.numberOfItemsInSection(0))
            self.contentSize.width = baseSize.width * scale < self.collectionView!.frame.size.width ? self.contentSize.width : baseSize.width * scale
            self.contentSize.height = baseSize.height * scale < self.collectionView!.frame.size.height ? self.contentSize.height : baseSize.height * scale
        }
        return self.contentSize
    }
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes?
    {
        let attributes = self.layoutAttributesForItemAtIndexPath(itemIndexPath)
        attributes.transform = CGAffineTransformMakeScale(0.1, 0.1);
        return attributes;
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]?
    {
        var paths = self.indexPathsOfItemsInRect(rect)
        var attributes:[UICollectionViewLayoutAttributes] = []
        var visibleRect = CGRect(origin: self.collectionView!.contentOffset, size: self.collectionView!.bounds.size)
        
        if CGRectIntersectsRect(visibleRect, rect) {
            for path in paths {
                attributes.append(self.layoutAttributesForItemAtIndexPath(path))
            }
        }
        return attributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes!
    {
        var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.frame = self.frameForItemAtIndexPath(indexPath)

        // Calculate item scale depending on distance from screen center
        var visibleRect = CGRect(origin: self.collectionView!.contentOffset, size: self.collectionView!.bounds.size)
        let dx = (CGRectGetMidX(visibleRect) - attributes.center.x) / (self.collectionView!.frame.size.width / 2.0)
        let dy = (CGRectGetMidY(visibleRect) - attributes.center.y) / (self.collectionView!.frame.size.height / 2.0)
        let scale = 1 - sqrt(dx*dx + dy*dy)
        let scaleFixed = scale < 0.25 ? 0.25 : scale

        attributes.size = CGSizeMake(attributes.size.width * scaleFixed, attributes.size.height * scaleFixed)
        return attributes
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool
    {
        return true
    }
    
    // MARK: Helpers
    
    func indexPathsOfItemsInRect(rect: CGRect) -> [NSIndexPath]
    {
        var paths:[NSIndexPath] = []
        let count = self.collectionView!.numberOfItemsInSection(0)
        for index in 0..<count {
            var path = NSIndexPath(forItem: index, inSection: 0)
            paths.append(path)
        }
        return paths
    }
    
    func frameForItemAtIndexPath(indexPath: NSIndexPath) -> CGRect
    {
        let center = CGPointMake(self.contentSize.width/2 - self.itemSize.width/2, self.contentSize.height/2 - itemSize.height/2)
        let offset = self.offsetForItem(indexPath.row)
        let angle = self.angleForItem(indexPath.row)
        let origin = CGPoint(x: CGFloat(center.x + offset * cos(angle)), y: CGFloat(center.y + offset * sin(angle)))
        let scale = self.collectionScale()
        
        return CGRect(x: origin.x, y: origin.y, width: self.itemSize.width * scale, height: self.itemSize.height * scale)
    }
    
    func itemMaxCountForLayer(layer: Int) -> Int
    {
        var itemCount : Int = 1
        for index in 0..<layer {
            itemCount += (index + 1) * 6
        }
        return itemCount
    }
    
    func itemCountOnLayer(layer: Int) -> Int
    {
        if layer == 0 {
            return 1
        }
        return layer * 6
    }
    
    func layerIndexForItemAtIndex(index: Int) -> Int
    {
        var layerIndex: Int = 0
        while (true) {
            if index < itemMaxCountForLayer(layerIndex) {
                break
            }
            layerIndex++
        }
        return layerIndex
    }
    
    func relativeItemIndex(index: Int) -> Int
    {
        if index == 0 {
            return 1
        }
        let layer = self.layerIndexForItemAtIndex(index)
        let lowerLayerItemCount = self.itemMaxCountForLayer(layer-1)

        return index - lowerLayerItemCount
    }
    
    func offsetForItem(index: Int) -> CGFloat
    {
        let layerIndex = self.layerIndexForItemAtIndex(index)
        return CGFloat(layerIndex) * CGFloat(self.itemSize.width * self.collectionScale()) - CGFloat(layerIndex*1) // Double(layerIndex*3) tightenes farther items to center
    }
    
    func angleForItem(index: Int) -> CGFloat
    {
        let itemCountOnLayer = self.itemCountOnLayer(self.layerIndexForItemAtIndex(index))
        let itemRelativeIndex = self.relativeItemIndex(index)
//        return CGFloat(M_PI) * 2.0 / CGFloat(itemCountOnLayer * itemRelativeIndex) // BUG, but why?
        return CGFloat(M_PI * 2 / Double(itemCountOnLayer) * Double(itemRelativeIndex))
    }
    
    func collectionScale() -> CGFloat
    {
        let collection = self.collectionView as MenuCollectionView
        return collection.scale
    }
    
    func collectionBaseContentSizeWithItemCount(count: Int) -> CGSize
    {
        let layerCount = self.layerIndexForItemAtIndex(count)
        let width = CGFloat(layerCount * 2 + 3) * self.itemSize.width
        let height = CGFloat(layerCount * 3) * self.itemSize.height
        return CGSizeMake(width, height)
    }
    
}

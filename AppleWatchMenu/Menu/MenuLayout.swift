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
    let itemSize = CGSizeMake(80, 80)
    
    required init(coder aDecoder: NSCoder)
    {
        super.init()
    }
    
    override func collectionViewContentSize() -> CGSize
    {
        return CGSizeMake(1000, 1000)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]?
    {
        var paths = self.indexPathsOfItemsInRect(rect)
        var attributes:[UICollectionViewLayoutAttributes] = []
        
        for path in paths {
            attributes.append(self.layoutAttributesForItemAtIndexPath(path))
        }
        return attributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes!
    {
        var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.frame = self.frameForItemAtIndexPath(indexPath)
        return attributes
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool
    {
        return false
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
        let center = self.collectionView!.center
        let offset = CGFloat(self.offsetForItem(indexPath.row))
        let angle = CGFloat(self.angleForItem(indexPath.row))
        let origin = CGPoint(x: CGFloat(center.x + offset * cos(angle)), y: CGFloat(center.y + offset * sin(angle)))
        
        return CGRect(x: origin.x, y: origin.y, width: self.itemSize.width, height: self.itemSize.height)
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
    
    func offsetForItem(index: Int) -> Double
    {
        let layerIndex = self.layerIndexForItemAtIndex(index)
        return Double(layerIndex) * 1.2 * Double(self.itemSize.width)
    }
    
    func angleForItem(index: Int) -> Double
    {
        let itemCountOnLayer = self.itemCountOnLayer(self.layerIndexForItemAtIndex(index))
        let itemRelativeIndex = self.relativeItemIndex(index)
        return M_PI * 2 / Double(itemCountOnLayer) * Double(itemRelativeIndex)
    }
    
    
}

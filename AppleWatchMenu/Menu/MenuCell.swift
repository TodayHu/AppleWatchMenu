//
//  MenuCell.swift
//  AppleWatchMenu
//
//  Created by Patryk Adamkiewicz on 17/11/14.
//  Copyright (c) 2014 Patryk Adamkiewicz. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    var icon = UIImageView(image: nil)
    
    override init(frame: CGRect)
    {
        icon.setTranslatesAutoresizingMaskIntoConstraints(false)
        super.init(frame: frame)
        self.addSubview(icon)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup()
    {
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[icon]|", options: nil, metrics: nil, views: ["icon":icon]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[icon]|", options: nil, metrics: nil, views: ["icon":icon]))
    }
}

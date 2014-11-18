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
        super.init(frame: frame)
        icon.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(icon)
        setupConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints()
    {
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[icon]|", options: nil, metrics: nil, views: ["icon":icon]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[icon]|", options: nil, metrics: nil, views: ["icon":icon]))
    }
}

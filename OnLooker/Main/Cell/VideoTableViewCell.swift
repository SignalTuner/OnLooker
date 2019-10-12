//
//  VideoTableViewCell.swift
//  OnLooker
//
//  Created by Jal Irani on 10/12/19.
//  Copyright © 2019 Jal Irani. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            let widthSpacing = 28.0
            let heightSpacing = 12.0
            var frame =  newFrame
            frame.origin.y += CGFloat((heightSpacing/2.0))
            frame.size.height -= CGFloat(heightSpacing)
            frame.origin.x += CGFloat((widthSpacing/2.0))
            frame.size.width -= CGFloat(widthSpacing)
            super.frame = frame
        }
    }

}

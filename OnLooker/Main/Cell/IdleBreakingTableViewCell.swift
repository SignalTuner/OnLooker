//
//  IdleBreakingTableViewCell.swift
//  OnLooker
//
//  Created by Jal Irani on 1/10/20.
//  Copyright © 2020 Jal Irani. All rights reserved.
//

import UIKit

class IdleBreakingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .red
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

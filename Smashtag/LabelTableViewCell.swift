//
//  LabelTableViewCell.swift
//  Smashtag
//
//  Created by Ioane Sharvadze on 11/26/15.
//  Copyright © 2015 Ioane Sharvadze. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {
    
    var label : String? {
        didSet{
            LabelView?.text = label
        }
    }

    @IBOutlet weak var LabelView: UILabel!
}

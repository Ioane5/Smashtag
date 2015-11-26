//
//  ImageTableViewCell.swift
//  Smashtag
//
//  Created by Ioane Sharvadze on 11/26/15.
//  Copyright © 2015 Ioane Sharvadze. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    var imageUrl : NSURL? {
        didSet {
            self.MediaImage?.image = nil
            if imageUrl != nil {
                let url = imageUrl!
                dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
                    let imageData = NSData(contentsOfURL: url)
                    // update UI if it this cell wasn't reused.
                    dispatch_async(dispatch_get_main_queue()) {
                        if self.imageUrl == url  && imageData != nil{
                            self.MediaImage?.image = UIImage(data: imageData!)
                        }
                    }
                }
            }
        }
    }
    
    // Never call ImageView, that bug made my hell. (because there is imageView internal variable ,
    // and I was setting that)
    @IBOutlet weak var MediaImage: UIImageView!
    


    
}

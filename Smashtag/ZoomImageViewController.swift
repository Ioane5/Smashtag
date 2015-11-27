//
//  ZoomImageViewController.swift
//  Smashtag
//
//  Created by Ioane Sharvadze on 11/27/15.
//  Copyright © 2015 Ioane Sharvadze. All rights reserved.
//

import UIKit

class ZoomImageViewController: UIViewController ,UIScrollViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private var MediaImage = UIImageView()
    
    private var image : UIImage? {
        get{
            return MediaImage.image
        }
        set{
            MediaImage.image = newValue
            MediaImage.sizeToFit()
            if ScrollView != nil {
                ScrollView.contentSize = MediaImage.frame.size
                ScrollView.minimumZoomScale = min(
                    ScrollView.frame.height/MediaImage.frame.height,
                    ScrollView.frame.width / MediaImage.frame.width )
                ScrollView.zoomScale = max(
                    ScrollView.frame.height/MediaImage.frame.height,
                    ScrollView.frame.width / MediaImage.frame.width )
            }
        }
    }
    
    var imageUrl : NSURL? {
        didSet {
            image = nil
            if imageUrl != nil {
                let url = imageUrl!
                dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
                    let imageData = NSData(contentsOfURL: url)
                    // update UI if it this cell wasn't reused.
                    dispatch_async(dispatch_get_main_queue()) {
                        if self.imageUrl == url  && imageData != nil{
                            self.image = UIImage(data: imageData!)
                        }
                    }
                }
            }
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return MediaImage
    }
    
    
    @IBOutlet weak var ScrollView: UIScrollView! {
        didSet {
            ScrollView.addSubview(MediaImage)
            ScrollView.contentSize = MediaImage.frame.size
            ScrollView.delegate = self
            ScrollView.maximumZoomScale = 5
        }
    }
    
}

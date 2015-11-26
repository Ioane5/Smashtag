//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Ioane Sharvadze on 11/26/15.
//  Copyright © 2015 Ioane Sharvadze. All rights reserved.
//

import UIKit


class TweetTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var tweetImageView: UIImageView!
    
    @IBOutlet weak var tweetScreenName: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    
    @IBInspectable var hashtagColor : UIColor = UIColor.greenColor()
    
    @IBInspectable var usernameColor : UIColor = UIColor.greenColor()
    
    @IBInspectable var urlColor : UIColor = UIColor.greenColor()
    
    
    var tweet : Tweet? {
        didSet {
            tweetImageView?.image = nil
            tweetTextLabel?.text = nil
            tweetScreenName?.text = nil
            
            // if tweet is not nil let's bind data
            if let tweet = self.tweet {
                
                var tweetText = tweet.text
                for _ in tweet.media {
                    tweetText += " 📷"
                }
                let attributedText = NSMutableAttributedString(string: tweetText)
                //let hashTagAttribute = [NSForegroundColorAttributeName : hashtagColor]
                
                for hashtag in tweet.hashtags {
                    attributedText.addAttribute(NSForegroundColorAttributeName, value: hashtagColor, range: hashtag.nsrange)
                }
                for url in tweet.urls {
                    attributedText.addAttribute(NSForegroundColorAttributeName, value: urlColor, range: url.nsrange)
                }
                for username in tweet.userMentions {
                    attributedText.addAttribute(NSForegroundColorAttributeName, value: usernameColor, range: username.nsrange)
                }                
                
                tweetTextLabel?.attributedText = attributedText
                
                tweetScreenName?.text = "\(tweet.user)"
                // if user has profile image
                if let profileImageURL = tweet.user.profileImageURL {
                    // run in background thread
                    dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
                        let imageData = NSData(contentsOfURL: profileImageURL)
                        // update UI if it this cell wasn't reused.
                        dispatch_async(dispatch_get_main_queue()) {
                            if self.tweet?.user.profileImageURL == profileImageURL {
                                if imageData == nil {
                                    self.tweetImageView?.image = nil
                                } else {
                                    self.tweetImageView?.image = UIImage(data: imageData!)
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
}

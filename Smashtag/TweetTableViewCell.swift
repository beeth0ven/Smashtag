//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by luojie on 4/20/15.
//  Copyright (c) 2015 luojie. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    var tweet : Tweet? {
        didSet {
            updateUI()
            
        }
    }
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    private func updateUI() {
        tweetProfileImageView?.image = nil
        screenNameLabel?.text = nil
        tweetTextLabel?.text = nil
        
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            
            screenNameLabel.text = "\(tweet.user)"
            
            if let profileImageURL = tweet.user.profileImageURL {
                
                let qos = Int(QOS_CLASS_USER_INITIATED.value)
                dispatch_async(dispatch_get_global_queue(qos, 0) , { () -> Void in
                    let imageData = NSData(contentsOfURL: profileImageURL)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            if imageData != nil {
                                self.tweetProfileImageView.image = UIImage(data: imageData!)
                            }else{
                                self.tweetProfileImageView.image = nil
                            }
                        
                        
                    })
                    
                })
                
                
            }
        }
    }
}

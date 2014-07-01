//
//  KeyboardViewController.swift
//  HodorKeyboard
//
//  Created by Jenei Viktor on 01/07/14.
//  Copyright (c) 2014 Epam Systems. All rights reserved.
//

import UIKit
import AVFoundation

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton
    var hodorImage : UIImage
    var hodorHighLightedImage : UIImage
    var player : AVAudioPlayer?

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        hodorImage = UIImage(named: "hodor")
        hodorHighLightedImage = UIImage(named: "hodor_highlighted")
        var soundPath = NSBundle.mainBundle().URLForResource("Hodor", withExtension: "mp3")
        if soundPath != nil {
            let soundData = NSData(contentsOfURL: soundPath)
            self.player = AVAudioPlayer(data: soundData, error:nil)
        }
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        self.nextKeyboardButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        self.nextKeyboardButton.setImage(UIImage(named: "globe"), forState: UIControlState.Normal)
        self.nextKeyboardButton.tintColor = UIColor.grayColor()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: UIControlEvents.TouchUpInside)
        self.nextKeyboardButton.sizeToFit()
        self.view.addSubview(self.nextKeyboardButton)
        let nextXLeftConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute:NSLayoutAttribute.Left, relatedBy:NSLayoutRelation.Equal, toItem:self.view, attribute:NSLayoutAttribute.Left, multiplier:1.0, constant:4)
        let nextYBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute:NSLayoutAttribute.Bottom, relatedBy:NSLayoutRelation.Equal, toItem:self.view, attribute:NSLayoutAttribute.Bottom, multiplier:1.0, constant:-4)
        let nextwidthConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute:NSLayoutAttribute.Width, relatedBy:NSLayoutRelation.Equal, toItem:nil, attribute:NSLayoutAttribute.Width, multiplier:1.0, constant:22)
        let nextheightConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute:NSLayoutAttribute.Height, relatedBy:NSLayoutRelation.Equal, toItem:nil, attribute:NSLayoutAttribute.Height, multiplier:1.0, constant:22)
        self.view.addConstraints([nextXLeftConstraint, nextYBottomConstraint])
        
        let hodorButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        hodorButton.setImage(hodorImage, forState: UIControlState.Normal)
        hodorButton.setImage(hodorHighLightedImage, forState: UIControlState.Highlighted)
        hodorButton.addTarget(self, action:"hodorButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        hodorButton.addTarget(self, action:"playHodorSound", forControlEvents: UIControlEvents.TouchDown)
        hodorButton.contentMode = UIViewContentMode.ScaleAspectFit
        hodorButton.sizeToFit()
        hodorButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(hodorButton)
        let xCenterConstraint = NSLayoutConstraint(item: hodorButton, attribute:NSLayoutAttribute.CenterX, relatedBy:NSLayoutRelation.Equal, toItem:self.view, attribute:NSLayoutAttribute.CenterX, multiplier:1.0, constant:0)
        let yCenterConstraint = NSLayoutConstraint(item: hodorButton, attribute:NSLayoutAttribute.CenterY, relatedBy:NSLayoutRelation.Equal, toItem:self.view, attribute:NSLayoutAttribute.CenterY, multiplier:1.0, constant:0)
        let widthConstraint = NSLayoutConstraint(item: hodorButton, attribute:NSLayoutAttribute.Width, relatedBy:NSLayoutRelation.Equal, toItem:nil, attribute:NSLayoutAttribute.Width, multiplier:1.0, constant:220)
        let heightConstraint = NSLayoutConstraint(item: hodorButton, attribute:NSLayoutAttribute.Height, relatedBy:NSLayoutRelation.Equal, toItem:nil, attribute:NSLayoutAttribute.Height, multiplier:1.0, constant:150)
        self.view.addConstraints([xCenterConstraint, yCenterConstraint, widthConstraint, heightConstraint])
        
    }

    @IBAction func hodorButtonPressed(sender : AnyObject?) {
        
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        proxy.insertText("hodor ")
    }
    
    @IBAction func playHodorSound() {
        if player?.data != nil {
            if player?.playing {
                player?.stop()
                player?.play()
            }
            else {
                player?.play()
            }
        }
    }
    
}

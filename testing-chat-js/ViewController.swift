//
//  ViewController.swift
//  testing-chat-js
//
//  Created by Mengying Feng on 28/07/2016.
//  Copyright © 2016 Mengying Feng. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ViewController:  JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // pin avatar to the top
        self.incomingCellIdentifier = "JSQIncoming"
        self.outgoingCellIdentifier = "JSQOutgoing"
        collectionView.registerNib(UINib(nibName: "JSQMessagesCollectionViewCellIncomingAvatarTop", bundle: nil), forCellWithReuseIdentifier: "JSQIncoming")
        collectionView.registerNib(UINib(nibName: "JSQMessagesCollectionViewCellOutgoingAvatarTop", bundle: nil), forCellWithReuseIdentifier: "JSQOutgoing")
        
        
        
        
        self.title = "Welcome Comments"
        setupBubbles()
        
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeMake(30, 30)
        //        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // hack \n
        addMessage("manager", text: "I'm calling you right now\n")
        addMessage(senderId, text: "I'm not sure how to XYZ something or another. \n")
        addMessage("manager", text: "Hello Chris. I'm Josh your acccount manager. Tap my picture to chat at any time.\n")
        
        finishReceivingMessage()
    }
    
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            return nil
        }
        
        return JSQMessagesAvatarImage(avatarImage: UIImage(named: "head"), highlightedImage: UIImage(named: "head"), placeholderImage: UIImage(named: "head"))
        
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        // apperance
        cell.textView.font = UIFont(name: "Avenir", size: 14)
        cell.cellTopLabel.font = UIFont(name: "Avenir", size: 10)
        cell.cellTopLabel.text = cell.cellTopLabel.text?.uppercaseString
        cell.cellTopLabel.backgroundColor = UIColor.clearColor()
        cell.cellTopLabel.textAlignment = .Left
        
        /*
        // set shadow
        cell.messageBubbleImageView.layer.masksToBounds = false
        cell.messageBubbleImageView.clipsToBounds = false
        cell.messageBubbleImageView.layer.shadowColor = UIColor.lightGrayColor().CGColor
        cell.messageBubbleImageView.layer.shadowOffset = CGSizeMake(0.1, 0.5)
        cell.messageBubbleImageView.layer.shadowOpacity = 1
        */
 
        // bubble size
        let customAttributes = self.collectionView.layoutAttributesForItemAtIndexPath(indexPath) as! JSQMessagesCollectionViewLayoutAttributes
        customAttributes.messageBubbleContainerViewWidth = UIScreen.mainScreen().bounds.size.width - cell.avatarImageView.layer.frame.size.width - 60
        cell.applyLayoutAttributes(customAttributes)
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView.textColor = UIColor.blackColor()
            cell.cellTopLabel.textColor = UIColor.blackColor()
        } else {
            cell.textView.textColor = UIColor.whiteColor()
            cell.cellTopLabel.textColor = UIColor.whiteColor()
        }
        
        
        
        return cell
    }
    
    // time stamp lable
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.item]
        return JSQMessagesTimestampFormatter.sharedFormatter().attributedTimestampForDate(message.date)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }

    
    
    // MARK: - Private Methods
    
    
    private func setupBubbles() {
        
        let blueBubble = JSQMessagesBubbleImageFactory(bubbleImage: UIImage(named: "BlueBubble"), capInsets: UIEdgeInsetsZero)
        let whiteBubble = JSQMessagesBubbleImageFactory(bubbleImage: UIImage(named: "WhiteBubble"), capInsets: UIEdgeInsetsZero)
        
        outgoingBubbleImageView = whiteBubble.outgoingMessagesBubbleImageWithColor(UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0))
        incomingBubbleImageView = blueBubble.incomingMessagesBubbleImageWithColor(UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1.0))
        
        
        
        
    }
    
    
    func addMessage(id: String, text: String) {
        let message = JSQMessage(senderId: id, displayName: "", text: text)
        messages.append(message)
    }
    
    
}
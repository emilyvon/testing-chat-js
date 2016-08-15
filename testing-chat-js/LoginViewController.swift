//
//  LoginViewController.swift
//  testing-chat-js
//
//  Created by Mengying Feng on 28/07/2016.
//  Copyright © 2016 Mengying Feng. All rights reserved.
//

import UIKit


// https://www.raywenderlich.com/122148/firebase-tutorial-real-time-chat
// https://github.com/jessesquires/JSQMessagesViewController

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func btnPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("showChat", sender: nil)
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let navVC = segue.destinationViewController as! UINavigationController
        let chatVC = navVC.viewControllers.first as! ViewController
        chatVC.senderId = "randomid"
        chatVC.senderDisplayName = "Emily Fung"
    }
 

}

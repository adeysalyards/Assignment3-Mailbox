//
//  InboxViewController.swift
//  Assignment3-Mailbox
//
//  Created by Salyards, Adey on 11/11/15.
//  Copyright © 2015 Salyards, Adey. All rights reserved.
//

import UIKit

class InboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var archiveView: UIView!
    @IBOutlet weak var laterView: UIView!
    var originalCenter: CGPoint!
    @IBOutlet weak var archiveButton: UIButton!
    @IBOutlet weak var laterButton: UIButton!
    @IBOutlet weak var hamburgerButton: UIButton!
    @IBOutlet weak var inboxView: UIView!
    @IBOutlet weak var feedImage: UIImageView!
    
    @IBOutlet var messageViewPanGesture: UIPanGestureRecognizer!
    
    var grayColor: UIColor!
    var greenColor: UIColor!
    var redColor: UIColor!
    var yellowColor: UIColor!
    var brownColor: UIColor!
    
    var initialCenter: CGPoint!
    var initialCenterArchiveButton: CGPoint!
    var initialCenterLaterButton: CGPoint!
    
    @IBOutlet weak var fakeView: UIView!
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redColor = UIColor(red: 235/255, green: 84/255, blue: 51/255, alpha: 1)
        grayColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        greenColor = UIColor(red: 112/255, green: 216/255, blue: 98/255, alpha: 1)
        yellowColor = UIColor(red: 250/227, green: 211/227, blue: 51/227, alpha: 1)
        brownColor = UIColor(red: 216/255, green: 165/255, blue: 117/255, alpha: 1)
        
        scrollView.contentSize = CGSize(width: 320, height: 1000)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        defaults.synchronize()
        
        if defaults.boolForKey("markedMessageForLater") {
            self.markedMessageForLater()
        }
    }
    
    func markedMessageForLater() {
        /*messageView.alpha = 0
        UIView.animateWithDuration(1, delay: 0, options: [], animations: { () -> Void in
            self.feedImage.center.y = self.feedImage.center.y - 86
            }) { (Bool) -> Void in
        }*/
        
        fakeView.backgroundColor = UIColor.redColor()
    }
    
    
    @IBAction func didPanMessageGesture(sender: UIPanGestureRecognizer) {
        
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            self.initialCenter = messageView.center
            self.initialCenterArchiveButton = archiveButton.center
            self.initialCenterLaterButton = laterButton.center
            
        }else if sender.state == UIGestureRecognizerState.Changed {
            
            self.messageView.center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y)
            
            if messageView.center.x >= 161 && messageView.center.x <= 261 {
                //drag to the right
                archiveView.alpha = 1
                laterView.alpha = 0
                archiveView.backgroundColor = grayColor
                self.archiveButton.selected = false
            }else if messageView.center.x >= 261 && messageView.center.x <= 411{
               archiveView.backgroundColor = greenColor
                self.archiveButton.selected = false
                archiveButton.center = CGPoint(x: initialCenterArchiveButton.x + translation.x - 80, y: initialCenterArchiveButton.y)
            }else if messageView.center.x >= 411 {
                archiveView.backgroundColor = redColor
                self.archiveButton.selected = true
                archiveButton.center = CGPoint(x: initialCenterArchiveButton.x + translation.x - 80, y: initialCenterArchiveButton.y)
                
            }else if messageView.center.x <= 161 && messageView.center.x >= 61 {
                //drag to the left
                archiveView.alpha = 0
                laterView.alpha = 1
                laterView.backgroundColor = grayColor
                self.laterButton.selected = false
            }else if messageView.center.x <= 61 && messageView.center.x >= -89 {
                laterView.backgroundColor = yellowColor
                laterButton.center = CGPoint(x: initialCenterLaterButton.x + translation.x + 80, y: initialCenterLaterButton.y)
                self.laterButton.selected = false
            }else if messageView.center.x <= -89 {
                laterButton.center = CGPoint(x: initialCenterLaterButton.x + translation.x + 80, y: initialCenterLaterButton.y)
                laterView.backgroundColor = brownColor
                self.laterButton.selected = true
            }
            
        }else if sender.state == UIGestureRecognizerState.Ended {
            
            if location.x >= 60 {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 20, options: [], animations: { () -> Void in
                    self.messageView.center = self.initialCenter
                    }, completion: { (Bool) -> Void in
                })
                
            } else if location.x <= 60 && location.x >= 40 {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 20, options: [], animations: { () -> Void in
                    self.messageView.center = self.initialCenter
                    }, completion: { (Bool) -> Void in
                })
                
            } else if location.x <= 40 {
                performSegueWithIdentifier("rescheduleSegue", sender: nil)
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 20, options: [], animations: { () -> Void in
                    self.messageView.center = self.initialCenter
                    }, completion: { (Bool) -> Void in
                })
            }
        }
    }

    @IBAction func didTapHamburgerButton(sender: AnyObject) {
        
        if hamburgerButton.selected == false {
            UIView.animateWithDuration(0.5, delay: 0, options: [], animations: { () -> Void in
                self.inboxView.center.x = 450
                }) { (Bool) -> Void in
            }
            self.hamburgerButton.selected = true
            
        }else if hamburgerButton.selected == true {
            UIView.animateWithDuration(0.5, delay: 0, options: [], animations: { () -> Void in
                self.inboxView.center.x = self.messageView.center.x
                }, completion: { (Bool) -> Void in
            })
            self.hamburgerButton.selected = false
        }
    }
    
    @IBAction func didPanInbox(sender: UIPanGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            messageViewPanGesture.enabled = false
        }else if sender.state == UIGestureRecognizerState.Changed {
            
        }else if sender.state == UIGestureRecognizerState.Ended {
            let velocity = sender.velocityInView(view)
            
            if velocity.x <= 0 {
                UIView.animateWithDuration(0.5, delay: 0, options: [], animations: { () -> Void in
                    self.inboxView.center.x = CGFloat(self.initialCenter.x)
                    }, completion: { (Bool) -> Void in
                })
                messageViewPanGesture.enabled = true
            }else if velocity.x >= 0 {
                UIView.animateWithDuration(0.5, delay: 0, options: [], animations: { () -> Void in
                    self.inboxView.center.x = 450
                    }) { (Bool) -> Void in
                }
            }

        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


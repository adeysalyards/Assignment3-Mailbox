//
//  RescheduleViewController.swift
//  Assignment3-Mailbox
//
//  Created by Salyards, Adey on 11/14/15.
//  Copyright © 2015 Salyards, Adey. All rights reserved.
//

import UIKit

class RescheduleViewController: UIViewController {
    
    var defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        defaults.setBool(true, forKey: "markedMessageForLater")
        defaults.synchronize()
        // Do any additional setup after loading the view.
    }
    
    func viewWillAppear() {
    
    }

    @IBAction func didPressBack(sender: AnyObject) {
        dismissViewControllerAnimated(true) { () -> Void in
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

//
//  SwitchingViewController.swift
//  viewswitcher
//
//  Created by Joe Malin on 2016-04-06.
//  Copyright © 2016 The Arwed Group. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController {
    private var blueViewController: BlueViewController!
    private var yellowViewController: YellowViewController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        blueViewController = storyboard?.instantiateViewControllerWithIdentifier("Blue") as! BlueViewController
        blueViewController.view.frame = view.frame
        switchViewController(from: nil, to: blueViewController)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        if blueViewController != nil && blueViewController!.view.superview == nil {
            blueViewController = nil
        }
        if yellowViewController != nil && yellowViewController!.view.superview == nil {
            yellowViewController = nil
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func switchViews(sender: UIBarButtonItem) {
        // Create the yellow view controller if needed
        if yellowViewController?.view.superview == nil {
            if yellowViewController == nil {
                if yellowViewController == nil {
                    yellowViewController = storyboard?.instantiateViewControllerWithIdentifier("Yellow") as! YellowViewController
                }
            }
        } else if blueViewController?.view.superview == nil {
            if blueViewController == nil {
                blueViewController = storyboard?.instantiateViewControllerWithIdentifier("Blue") as! BlueViewController
            }
        }
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.EaseInOut)
        
        // Switch the controllers
        if blueViewController != nil && blueViewController!.view.superview != nil {
            UIView.setAnimationTransition(.FlipFromRight, forView: view, cache: true)
            yellowViewController.view.frame = view.frame
            switchViewController(from: blueViewController, to: yellowViewController)
        } else {
            UIView.setAnimationTransition(.FlipFromLeft, forView: view, cache: true)
            blueViewController.view.frame = view.frame
            switchViewController(from: yellowViewController, to: blueViewController)
        }
    }
    private func switchViewController(from fromVC: UIViewController?, to toVC: UIViewController?) {
        
        // Does the starting view controller already exist?
        // (A value of "nil" indicates that the switch is going from yellow to blue (yellow doesn't exist until the
        // program switches to it, aka "lazy loading")
        if fromVC != nil {
            // Notify the view controller that it's being removed from its parent
            fromVC!.willMoveToParentViewController(nil)
            // Remove the view from the parent View
            fromVC!.view.removeFromSuperview()
            // Remove the view controller from the parent ViewController (SwitchViewController)
            fromVC!.removeFromParentViewController()
        }
        
        // Ensure that the result view controller always exists. It should, but this makes certain
        if toVC != nil {
            // Add the new ViewController as a child of "self", which is switchViewController
            self.addChildViewController(toVC!)
            // Add the new View at the back, to ensure it doesn't appear in front of the toolbar
            self.view.insertSubview(toVC!.view, atIndex: 0)
            // Mark that the new view controller is now a child of switchViewController
            toVC!.didMoveToParentViewController(self)
        }
        UIView.commitAnimations()
        
    }

}

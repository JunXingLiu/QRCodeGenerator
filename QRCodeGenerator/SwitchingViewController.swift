//
//  SwitchingViewController.swift
//  Assignment2
//
//  Created by Jun Xing Liu on 2/6/20.
//  Copyright © 2020 Jun Xing Liu. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController {

    private var firstViewController: FirstViewController!
    private var secondViewController: SecondViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstViewController =
            storyboard?.instantiateViewController(withIdentifier: "First")
            as! FirstViewController
        firstViewController.view.frame = view.frame
        switchViewController(from: nil, to: firstViewController)
        
        // Do any additional setup after loading the view.
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask  {
        if let _ = presentedViewController as? FirstViewController {
            return .portrait
        }
        
        return .allButUpsideDown
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        if firstViewController != nil
            && firstViewController!.view.superview == nil {
            firstViewController = nil
        }
        if secondViewController != nil
            && secondViewController!.view.superview == nil {
            secondViewController = nil
        }
    }
    
    @IBAction func switchViews(sender: UIBarButtonItem) {
        // Create the new view controller, if required
        if secondViewController?.view.superview == nil {
            if secondViewController == nil {
                secondViewController =
                    storyboard?.instantiateViewController(withIdentifier: "Second")
                    as! SecondViewController
            }
        } else if firstViewController?.view.superview == nil {
            if firstViewController == nil {
                firstViewController =
                    storyboard?.instantiateViewController(withIdentifier: "First")
                    as! FirstViewController
            }
        }
        
        // Switch view controllers
        if firstViewController != nil
            && firstViewController!.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight,
                                          for: view, cache: true)
            secondViewController.view.frame = view.frame
            switchViewController(from: firstViewController,
                                 to: secondViewController)
        } else {
            UIView.setAnimationTransition(.flipFromLeft,
                                          for: view, cache: true)
            firstViewController.view.frame = view.frame
            switchViewController(from: secondViewController,
                                 to: firstViewController)
        }
        UIView.commitAnimations()
    }
    
    private func switchViewController(from fromVC:UIViewController?,
                                      to toVC:UIViewController?) {
        if fromVC != nil {
            fromVC!.willMove(toParent: nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParent()
        }
        
        if toVC != nil {
            self.addChild(toVC!)
            self.view.insertSubview(toVC!.view, at: 0)
            toVC!.didMove(toParent: self)
        }
    }

}

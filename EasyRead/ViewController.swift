//
//  ViewController.swift
//  EasyRead
//
//  Created by Kyle Lee on 12/6/15.
//  Copyright © 2015 Kilo Loco. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBtmConstraint: NSLayoutConstraint!
    @IBOutlet weak var clearBtnBtmConstraint: NSLayoutConstraint!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    func resetBtmConstraint() {
        clearBtnBtmConstraint.constant = 8
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                self.textViewBtmConstraint.constant = keyboardHeight
                self.clearBtnBtmConstraint.constant = keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.textViewBtmConstraint.constant = 0
        self.resetBtmConstraint()
    }
    
    @IBAction func clearBtnPressed(sender: UIButton) {
        self.textView.text = ""
    }
    
}


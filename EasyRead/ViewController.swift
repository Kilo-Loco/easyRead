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
    @IBOutlet weak var doneBtnBtmConstraint: NSLayoutConstraint!
    @IBOutlet weak var doneButton: UIButton!
    
    let CTA = "Type or use dictation."
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.delegate = self
        self.doneButton.hidden = true
        self.textView.text = self.CTA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    func resetBtmConstraint() {
        self.textViewBtmConstraint.constant = 0
        self.clearBtnBtmConstraint.constant = 8
        self.doneBtnBtmConstraint.constant = 8
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                self.textViewBtmConstraint.constant = keyboardHeight
                self.clearBtnBtmConstraint.constant = keyboardHeight
                self.doneButton.hidden = false
                self.doneBtnBtmConstraint.constant = keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if self.textView.text == CTA {
            self.textView.text = ""
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.textViewBtmConstraint.constant = 0
        self.resetBtmConstraint()
    }
    
    @IBAction func clearBtnPressed(sender: UIButton) {
        self.textView.text = ""
    }
    
    @IBAction func doneBtnPressed(sender: UIButton) {
        self.view.endEditing(true)
        self.doneButton.hidden = true
    }
}


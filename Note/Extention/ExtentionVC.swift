//
//  ExtentionVC.swift
//  Note
//
//  Created by Sarf on 25.01.2021.
//

import UIKit

extension ViewController: UIGestureRecognizerDelegate {
    
    //MARK: Observer and recognizer
    func swipeObservers() {
          let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector (handleSwipes))
          swipeRight.direction = .right
          self.view.addGestureRecognizer(swipeRight)
          
          let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector (handleSwipes))
          swipeLeft.direction = .left
          self.view.addGestureRecognizer(swipeLeft)
          
          let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector (handleSwipes))
          swipeUp.direction = .up
          self.view.addGestureRecognizer(swipeUp)
          
          let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector (handleSwipes))
          swipeDown.direction = .down
          self.view.addGestureRecognizer(swipeDown)
      }
    
    @objc func handleSwipes(gester: UISwipeGestureRecognizer){
            switch gester.direction {
            case .right:
                navigationController?.popToRootViewController(animated: true)
            default:
                break
            }
        }
    
    func tapObserver() {
            let tripleTap = UITapGestureRecognizer(target: self, action: #selector(tripleTapAction))
            tripleTap.numberOfTapsRequired = 3
            self.view.addGestureRecognizer(tripleTap)
        
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
            doubleTap.require(toFail: tripleTap)
            doubleTap.numberOfTapsRequired = 2
            self.view.addGestureRecognizer(doubleTap)
        }
    
        @objc func doubleTapAction() {
        }

        @objc func tripleTapAction() {
        }
    
}

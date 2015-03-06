//
//  CarpenterViewController.swift
//  Parallax
//
//  Created by viramesh on 3/4/15.
//  Copyright (c) 2015 vbits. All rights reserved.
//

import UIKit

class CarpenterViewController: UIViewController {

    @IBOutlet weak var frameView: UIImageView!
    var frameViewStartingPoint:CGFloat!
    
    var imageNamePrefix:String = "demo1 "
    var imageNameMIN:Int = 020
    var imageNameMAX:Int = 174
    var imageSpeed:CGFloat = 0.5
    var currentImage:Int!
    var initialImage:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentImage = imageNameMIN
        
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -160
        horizontalMotionEffect.maximumRelativeValue = 160
        frameView.addMotionEffect(horizontalMotionEffect)
        frameViewStartingPoint = frameView.center.x
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func imageDidPan(sender: UIPanGestureRecognizer) {
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            initialImage = currentImage
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            currentImage = initialImage + Int(translation.x * imageSpeed)
            if(currentImage < imageNameMIN) {
                currentImage = imageNameMIN
            }
            else if(currentImage > imageNameMAX) {
                currentImage = imageNameMAX
            }
            
            var frameNum:String = ""
            if(String(currentImage).utf16Count == 2) {
                frameNum = "0" + String(currentImage)
            }
            else {
                frameNum = String(currentImage)
            }
            var newFrame = imageNamePrefix + frameNum
            //println(newFrame)
            frameView.image = UIImage(named: newFrame)
            frameView.center.x = frameViewStartingPoint - CGFloat(currentImage - imageNameMIN)
        }
        else if sender.state == UIGestureRecognizerState.Ended {

        }
    }

}

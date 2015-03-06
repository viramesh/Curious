//
//  ViewController.swift
//  Parallax
//
//  Created by viramesh on 3/3/15.
//  Copyright (c) 2015 vbits. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frameView: UIImageView!
    
    var imageNamePrefix:String = "SONY_FULL_DROP_05_00"
    var imageNameMIN:Int = 818
    var imageNameMAX:Int = 1038
    var imageSpeed:CGFloat = 0.1
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
            
            frameView.image = UIImage(named: imageNamePrefix + String(currentImage))
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            
        }
    }

}


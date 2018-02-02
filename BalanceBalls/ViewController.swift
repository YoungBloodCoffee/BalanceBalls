//
//  ViewController.swift
//  BalanceBalls
//
//  Created by Nate Kosin on 11/4/16.
//  Copyright © 2016 Nate Kosin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    var masterBall: UIView!
    var ballArray = [UIView]()
    
    // SLEEP BEFORE NEW BALL ADDED
    func Sleep(){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            self.ballArray.append(self.createBall(size: 75, corner: 37.5))
        })
    }
    // CREATE BALL FUNC
    func createBall(size: Int = 75, corner: Float = 37.5) -> UIView {
        let square = UIView(frame: CGRect(x: 175, y: 0, width: size, height: size))
        square.layer.cornerRadius = CGFloat(corner)
        square.backgroundColor = UIColor.gray
        view.addSubview(square)
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [square])
        animator.addBehavior(gravity)
        collision = UICollisionBehavior(items: [square])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        let itemBehavior = UIDynamicItemBehavior(items: [square])
        itemBehavior.elasticity = 0.2
        animator.addBehavior(itemBehavior)
        // collision.addBoundary(withIdentifier: "square" as NSCopying, for: UIBezierPath(rect: square.frame))
        return square
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: CGFloat(view.center.x + translation.x), y: CGFloat(view.center.y + translation.y))
        }
        let pointZero = CGPoint(x:0, y:0)
        recognizer.setTranslation(pointZero, in: self.view)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.masterBall = createBall(size: 100, corner: 50)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        masterBall.addGestureRecognizer(pan)
        Sleep()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


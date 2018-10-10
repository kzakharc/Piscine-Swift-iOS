//
//  MainViewController.swift
//  MotionCube
//
//  Created by Kateryna Zakharchuk on 09.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit
import CoreMotion

fileprivate enum Shape {
    case square
    case circle
}

class MainViewController: UIViewController {
    
    var randomViews = [UIView]()
    var animator = UIDynamicAnimator()
    
    var gravity = UIGravityBehavior(items: [])
    var collision = UICollisionBehavior(items: [])
    var elasticity = UIDynamicItemBehavior(items: [])
    
    var motionManager: CMMotionManager!
    
    private let shapes: [Shape] = [.square, .circle]
    private let colors: [UIColor] = [.lightPink, .iceBlue, .lime, .orange, .lightPurple, .lemon, .ladyInRed]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: handleAccelerometerUpdate)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func handleAccelerometerUpdate(data: CMAccelerometerData?, error: Error?) -> Void {
        if let d = data {
            self.gravity.gravityDirection = CGVector(dx: d.acceleration.x, dy: -d.acceleration.y);
        }
    }
    
    func addRandomView(on point: CGPoint) {
        randomViews.append(UIView())
        
        let randomView = randomViews[randomViews.count - 1]
        
        randomView.layer.borderWidth = 1
        randomView.layer.borderColor = UIColor.lightGray.cgColor
        
        let viewColor = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        let randomShape = shapes[Int(arc4random_uniform(UInt32(shapes.count)))]
        
        randomView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        randomView.backgroundColor = viewColor
        
        if randomShape == .circle {
            randomView.layer.cornerRadius = randomView.frame.width / 2
            randomView.clipsToBounds = true
        } else {
            randomView.clipsToBounds = false
        }
        
        randomView.center = point
        view.addSubview(randomView)
        
        let gravity = UIGravityBehavior(items: [randomView])
        animator.addBehavior(gravity)
        
        let collision = UICollisionBehavior(items: randomViews)
        
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.addBoundary(withIdentifier: "leftBorder" as NSCopying, from: CGPoint(x: 0, y: 0), to: CGPoint(x: 0, y: view.bounds.size.height))
        collision.addBoundary(withIdentifier: "rightBorder" as NSCopying, from: CGPoint(x: view.bounds.size.width, y: 0), to: CGPoint(x: view.bounds.size.width, y: view.bounds.size.height))
        collision.addBoundary(withIdentifier: "topBorder" as NSCopying, from: CGPoint(x: 0, y: view.bounds.size.height), to: CGPoint(x: view.bounds.size.width, y: view.bounds.size.height))
        animator.addBehavior(collision)
        
        let elasticity = UIDynamicItemBehavior(items: randomViews)
        elasticity.elasticity = 0.6
        animator.addBehavior(elasticity)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panView))
        randomView.addGestureRecognizer(panGestureRecognizer)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotating))
        randomView.addGestureRecognizer(rotationGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        randomView.addGestureRecognizer(pinchGesture)
    }
    
    @objc func tapView(_ sender: UITapGestureRecognizer) {
        let touchCoordinate = sender.location(ofTouch: sender.numberOfTouchesRequired - 1, in: view)
        addRandomView(on: touchCoordinate)
    }
    
    @objc func panView(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            gravity.removeItem(sender.view!)
            sender.view?.center = sender.location(in: self.view)
            animator.updateItem(usingCurrentState: sender.view!)
        } else if sender.state == .cancelled {
            gravity.addItem(sender.view!)
        }
    }
    
    @objc func rotating(_ sender: UIRotationGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            gravity.removeItem(sender.view!)
            sender.view!.transform = sender.view!.transform.rotated(by: sender.rotation)
            sender.rotation = 0
        } else if sender.state == .cancelled {
            gravity.addItem(sender.view!)
        }
    }
    
    @objc func pinch(_ sender: UIPinchGestureRecognizer) {
        view.bringSubview(toFront: sender.view!)
        
        if sender.state == .began || sender.state == .changed {
            gravity.removeItem(sender.view!)
            collision.removeItem(sender.view!)
            elasticity.removeItem(sender.view!)
            animator.removeAllBehaviors()
            
            sender.view?.layer.bounds.size.height *= sender.scale
            sender.view?.layer.bounds.size.width *= sender.scale
            
            if sender.view?.clipsToBounds == true {
                sender.view!.layer.cornerRadius *= sender.scale
            }
            sender.scale = 1
        } else if sender.state == .ended {
                let gravity = UIGravityBehavior(items: randomViews)
                animator.addBehavior(gravity)
                
                let collision = UICollisionBehavior(items: randomViews)
                
                collision.translatesReferenceBoundsIntoBoundary = true
                collision.addBoundary(withIdentifier: "leftBorder" as NSCopying, from: CGPoint(x: 0, y: 0), to: CGPoint(x: 0, y: view.bounds.size.height))
                collision.addBoundary(withIdentifier: "rightBorder" as NSCopying, from: CGPoint(x: view.bounds.size.width, y: 0), to: CGPoint(x: view.bounds.size.width, y: view.bounds.size.height))
                collision.addBoundary(withIdentifier: "topBorder" as NSCopying, from: CGPoint(x: 0, y: view.bounds.size.height), to: CGPoint(x: view.bounds.size.width, y: view.bounds.size.height))
                animator.addBehavior(collision)
                
                let elasticity = UIDynamicItemBehavior(items: randomViews)
                elasticity.elasticity = 0.6
                animator.addBehavior(elasticity)
        }
    }
}



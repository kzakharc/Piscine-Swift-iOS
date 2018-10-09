//
//  MainViewController.swift
//  MotionCube
//
//  Created by Kateryna Zakharchuk on 09.10.2018.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

fileprivate enum Shape {
    case square
    case circle
}

class MainViewController: UIViewController {
    
    var randomViews = [UIView]()
    var animator = UIDynamicAnimator()
    var gravity = UIGravityBehavior(items: [])
    
    private let shapes: [Shape] = [.square, .circle]
    private let colors: [UIColor] = [.lightPink, .iceBlue, .lime, .orange, .lightPurple, .lemon, .ladyInRed]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addRandomView(on point: CGPoint) {
        randomViews.append(UIView())
        
        let randomView = randomViews[randomViews.count - 1]
        
        let viewColor = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        let randomShape = shapes[Int(arc4random_uniform(UInt32(shapes.count)))]
        
        randomView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        randomView.backgroundColor = viewColor
        
        if randomShape == .circle {
            randomView.layer.cornerRadius = randomView.frame.width / 2
            randomView.clipsToBounds = true
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
        
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
//        randomView.addGestureRecognizer(pinchGesture)
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
    
//    @objc func pinch(_ sender: UIPinchGestureRecognizer) {
//        view.bringSubview(toFront: sender.view!)
//        sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
//        sender.scale = 1.0
////        if sender.state == .began || sender.state == .changed {
////            gravity.removeItem(sender.view!)
////            sender.view!.transform = sender.view!.transform.rotated(by: sender.rotation)
////            sender.rotation = 0
////        } else if sender.state == .cancelled {
////            gravity.addItem(sender.view!)
////        }
//    }
}



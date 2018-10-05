//
//  ScrollViewController.swift
//  APM
//
//  Created by pc166 on 10/4/18.
//  Copyright © 2018 pc166. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        scrollView.maximumZoomScale = 1.5
        updateZoom(forViewSize: view.bounds.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateZoom(forViewSize: size)
    }
    
    func updateZoom(forViewSize size: CGSize) {
        scrollView.setZoomScale(1.0, animated: true)
        scrollView.maximumZoomScale = 1.5
        let zoomScale = size.width / self.imageView.image!.size.width
        scrollView.minimumZoomScale = zoomScale > 1 ? 1 : zoomScale
    }
}

extension ScrollViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

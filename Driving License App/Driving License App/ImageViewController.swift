//
//  ImageViewController.swift
//  Driving License App
//
//  Created by Koba Kareli on 11/01/2016.
//  Copyright © 2016 Koba Kareli. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

   
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentMode = .ScaleAspectFit
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.1
            scrollView.maximumZoomScale = 2.0

        }
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var imageView = UIImageView()
    
    // stores image of the UIImageView
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let scrv = scrollView {
            if image != nil {
                let scrollViewSize = scrv.bounds.size
                let imageViewSize = imageView.bounds.size
                scrv.zoomScale = max(scrollViewSize.width/imageViewSize.width, scrollViewSize.height/imageViewSize.height)
            }
        }
    }
}

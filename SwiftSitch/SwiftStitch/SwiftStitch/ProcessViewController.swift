//
//  ProcessViewController.swift
//  SwiftStitch
//
//  Created by devadmin on 14/09/2022.
//

import UIKit

class ProcessViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var processImage: UIImageView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Variables
    var images: [UIImage]?
    
    // MARK: - Constants
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 0.15
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        
        // Start process
        stitch()
    }
    
    // MARK: - IBActions
    
    // MARK: - Custom Funtions
    func stitch() {
        spinner.startAnimating()
        loadingView.isHidden = false
        blurView.isHidden = false
        if let captured = images {
            DispatchQueue.background(delay: 0.5, background: {
                if let stitchedImage: UIImage = try? CVWrapper.process(with: captured) as UIImage {
                    DispatchQueue.main.async { [unowned self] in
                        processImage.image = stitchedImage
                    }
                }
            }, completion: { [unowned self] in
                spinner.stopAnimating()
                blurView.isHidden = true
                loadingView.isHidden = true
            })
        }
    }
}

extension ProcessViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return processImage
    }
}

extension DispatchQueue {
    static func background(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}

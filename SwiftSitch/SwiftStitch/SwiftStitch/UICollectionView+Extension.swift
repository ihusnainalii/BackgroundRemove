//
//  UICollectionView+Extension.swift
//  SwiftStitch
//
//  Created by devadmin on 14/09/2022.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func updateFLow(_ itemSpacing: CGFloat = 5, _ lineSpacing: CGFloat = 5, _ ishorizontal: Bool) {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flow.minimumInteritemSpacing = itemSpacing
        flow.minimumLineSpacing = lineSpacing
        flow.scrollDirection = ishorizontal ? .horizontal : .vertical
        
        // Apply flow layout
        self.setCollectionViewLayout(flow, animated: true)
    }
    
    func isScrollEnable(isEnable: Bool) {
        self.isScrollEnabled = isEnable
    }
    
    func clearBackground() {
        self.backgroundColor = .clear
        self.backgroundView = UIView(frame: .zero)
    }
    
    func confirm(_ view: UIViewController) {
        self.delegate = view as? UICollectionViewDelegate
        self.dataSource = view as? UICollectionViewDataSource
        self.refreshControl?.tintColor = .clear
        self.refreshControl?.backgroundColor = .clear
    }
    
    func register(_ identifier: String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
}

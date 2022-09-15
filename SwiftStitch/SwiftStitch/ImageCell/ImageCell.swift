//
//  ImageCell.swift
//  SwiftStitch
//
//  Created by devadmin on 14/09/2022.
//

import UIKit

class ImageCell: UICollectionViewCell {

    // MARK: - Identifier
    static let identifier = "ImageCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var cellImage: UIImageView!
    
    // MARK: - Variables
    var clickHandler: ((Int) -> Void)?
    
    // MARK: - Constants
    
    // MARK: - View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ image: UIImage) {
        cellImage.image = image
    }

    func watchForClickHandler(completion: @escaping (Int) -> Void) {
        self.clickHandler = completion
    }
    
    @IBAction func BtnTapped(_ sender: UIButton) {
        guard let completion = self.clickHandler else {return}
        completion(0)
    }
}

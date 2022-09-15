//
//  SelectionViewController.swift
//  SwiftStitch
//
//  Created by devadmin on 14/09/2022.
//

import UIKit

class SelectionViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var btnProcess: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var images: [UIImage] = [] {
        didSet {
            print("images count: \(images.count)")
            btnProcess.isHidden = images.count == 0
            collectionView.reloadData()
        }
    }
    
    // MARK: - Constants
    let picker = UIImagePickerController()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Navigation bar
        self.title = "Choose Images"
        
        // Delegate
        picker.delegate = self
        btnProcess.isHidden = true
        collectionView.confirm(self)
        collectionView.updateFLow(0, 0, false)
        collectionView.register(ImageCell.identifier)
        
        // get demo images
        for i in 1...4 {
            if let image = UIImage(named: "\(i)") {
                images.append(image)
            }
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func processImages(_ sender: UIButton) {
        if let view = self.storyboard?.instantiateViewController(withIdentifier: "ProcessViewController") as? ProcessViewController {
            view.images = self.images
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    @IBAction func btnChooseImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "CHOSE_IMAGE_LBL", message: "PLEASE_CHOSE_IMAGE", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "SELECT_FROM_PHOTOS", style: .default, handler: {(_) in
            self.chooseImage()
        }))
        alert.addAction(UIAlertAction(title: "CAPTURE_IMAGE", style: .default, handler: {(_) in
            self.captureImage()
        }))
        alert.addAction(UIAlertAction(title: "CANCEL_LBL", style: .cancel, handler: nil))
        if let popoverPresentationController = alert.popoverPresentationController {
            popoverPresentationController.sourceView = sender
            popoverPresentationController.sourceRect = sender.bounds
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Custom Funtions
    func chooseImage() {
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.image"]
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func captureImage() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        } else {
            print("CAMERA_NOT_AVAILABLE")
        }
    }
}

// Image picker extension
extension SelectionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        if let selectedImage = selectedImage {
            self.images.append(selectedImage)
        }
        
        // Dimisss
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}


extension SelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // Cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        
        // Data Set
        cell.cellImage.round(12)
        cell.configure(images[indexPath.row])
        cell.watchForClickHandler { [unowned self] _ in
            images.remove(at: indexPath.row)
        }
        
        // Return Cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width) / 3
        return CGSize(width: size, height: size + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
}

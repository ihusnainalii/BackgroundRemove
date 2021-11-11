//
//  ViewController.swift
//  Background Remover
//
//  Created by devadmin on 11/11/2021.
//

import UIKit
import Photos
import MobileCoreServices

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var selectedImg: UIImageView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnChoose: UIButton!
    @IBOutlet weak var textlbl: UILabel!
    
    // MARK: - Variables
    var isImageSelected = false
    
    // MARK: - Constants
    let picker = UIImagePickerController()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Deleagte
        picker.delegate = self
        
        // Update view
        updateView()
    }

    // MARK: - IBActions
    @IBAction func updateContentMode(_ sender: UISegmentedControl) {
        selectedImg.contentMode = sender.selectedSegmentIndex == 0 ? .scaleAspectFit : .scaleAspectFill
    }
    
    @IBAction func btnRemoveTapped(_ sender: UIButton) {
        isImageSelected = false
        selectedImg.image = nil
        updateView()
    }
    
    @IBAction func btnChooseTapped(_ sender: UIButton) {
        if isImageSelected {
            if let view = self.storyboard?.instantiateViewController(withIdentifier: "ImageRemoverView") as? ImageRemoverView {
                view.selectedImage = selectedImg.image
                self.present(view, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Choose Image", message: "Please select or capture image to proceed", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Select From Photos", style: .default, handler: {(_) in
                self.chooseImage()
            }))
            alert.addAction(UIAlertAction(title: "Capture Image", style: .default, handler: {(_) in
                self.captureImage()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            if let popoverPresentationController = alert.popoverPresentationController {
                popoverPresentationController.sourceView = sender
                popoverPresentationController.sourceRect = sender.bounds
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Custom Functions
    /// Capture Image from camera if available
    func captureImage() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        } else {
            print("No Camera found")
        }
    }
    
    /// Choose Image from gallery
    func chooseImage() {
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.mediaTypes = [kUTTypeImage] as [String]
        present(picker, animated: true, completion: nil)
    }
    
    /// Update View
    func updateView() {
        selectedImg.isHidden = !isImageSelected
        btnRemove.isHidden = !isImageSelected
        segment.isHidden = !isImageSelected
        textlbl.isHidden = isImageSelected
        btnChoose.setTitle(isImageSelected ? "Procced" : "Choose Image", for: .normal)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// Image picker Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        // Save image to gallery
        // UIImageWriteToSavedPhotosAlbum(selectedImage ?? UIImage(), nil, nil, nil)
        
        // Update View
        isImageSelected = true
        selectedImg.image = selectedImage
        updateView()
        
        // Dimisss
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

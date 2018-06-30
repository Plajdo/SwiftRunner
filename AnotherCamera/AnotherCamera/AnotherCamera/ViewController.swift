//
//  ViewController.swift
//  AnotherCamera
//
//  Created by Filip Šašala on 30/06/2018.
//  Copyright © 2018 plajdo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	@IBOutlet var imageView: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
		if(UIImagePickerController.isSourceTypeAvailable(.camera)){
			let imagePickerController = UIImagePickerController()	//New picker instance
			imagePickerController.delegate = self					//Class that can use the controller
			imagePickerController.sourceType = .camera				//Source - camera or library
			
			self.present(imagePickerController, animated: true, completion: nil)
		}else{
			let alert = UIAlertController(title: "Error", message: "Camera not available.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
		
    }
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		let image : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
		imageView.image = image
		picker.dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true, completion: nil)
	}
    
}


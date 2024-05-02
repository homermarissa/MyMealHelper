//
//  CustomMenu2ViewController.swift
//  MyMealPlanner
//
//  Created by Marissa Homer on 2/7/24.
//

import UIKit

class CustomMenu2ViewController: UIViewController , UITextViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var mealPicture2: UIImageView!
    
    @IBOutlet weak var meal2NameTitle: UILabel!
    
    @IBOutlet weak var meal2NameTextField: UITextField!
    @IBOutlet weak var mealDescription2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mealDescriptionTextViewFunctionality(mealDescription2)
        loadSavedData()
        meal2NameTextField.delegate = self
        if mealDescription2.text == "Enter meal description" {
                mealDescription2.text = "Enter meal description"
                mealDescription2.textColor = UIColor.placeholderText
            } else {
                mealDescription2.textColor = UIColor.black
            }
    }
    
    @IBAction func nextButton2(_ sender: Any) {
        performSegue(withIdentifier: "meal3Page", sender: self)
    }
    
    
    @IBAction func editingDidEndMealName(_ sender: Any) {
        meal2NameTitle.text = meal2NameTextField.text
        saveData()
        
    }
    func mealDescriptionTextViewFunctionality(_ textView: UITextView){
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.systemGray6.cgColor
        textView.delegate = self
        textView.text = "Enter meal description"
        textView.textColor = UIColor.placeholderText
        
    }
    // Function to save meal data to UserDefaults
        func saveData() {
            UserDefaults.standard.set(meal2NameTextField.text, forKey: "mealName2")
            UserDefaults.standard.set(mealDescription2.text, forKey: "mealDescription2")
            if let imageData = mealPicture2.image?.pngData() {
                UserDefaults.standard.set(imageData, forKey: "mealPicture2")
            }
        }
        
        // Function to load saved meal data from UserDefaults
        func loadSavedData() {
            if let mealName = UserDefaults.standard.string(forKey: "mealName2") {
                meal2NameTitle.text = mealName
                meal2NameTextField.text = mealName
            }
            if let mealDescription = UserDefaults.standard.string(forKey: "mealDescription2") {
                mealDescription2.text = mealDescription
            }
            if let imageData = UserDefaults.standard.data(forKey: "mealPicture2") {
                mealPicture2.image = UIImage(data: imageData)
            }
        }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.placeholderText {
                textView.text = ""
                textView.textColor = UIColor.black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = "Enter meal description"
                textView.textColor = UIColor.placeholderText
            }
            saveData() // Save data when editing ends
        }
    @IBAction func changePictureButton2(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    

}
extension CustomMenu2ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            mealPicture2.image = editedImage
            saveData() // Save the image here
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

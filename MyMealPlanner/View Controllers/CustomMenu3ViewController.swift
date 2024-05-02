//
//  CustomMenu3ViewController.swift
//  MyMealPlanner
//
//  Created by Marissa Homer on 4/3/24.
//

import UIKit



class CustomMenu3ViewController: UIViewController , UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mealDescription3: UITextView!
    @IBOutlet weak var meal3NameTextField: UITextField!
    @IBOutlet weak var mealPicture3: UIImageView!
    @IBOutlet weak var meal3NameTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mealDescriptionTextViewFunctionality(mealDescription3)
        meal3NameTextField.delegate = self // Assigning the delegate here
        loadSavedData() // Load saved data when view loads
        if mealDescription3.text == "Enter meal description" {
                mealDescription3.text = "Enter meal description"
                mealDescription3.textColor = UIColor.placeholderText
            } else {
                mealDescription3.textColor = UIColor.black
            }
    }
    // UITextFieldDelegate method to handle editing ending for meal name
        func textFieldDidEndEditing(_ textField: UITextField) {
            meal3NameTitle.text = textField.text
            saveData() // Save data when editing ends
        }

        // Function to customize meal description text view appearance
        func mealDescriptionTextViewFunctionality(_ textView: UITextView){
            textView.layer.borderWidth = 1
            textView.layer.cornerRadius = 10
            textView.layer.borderColor = UIColor.systemGray6.cgColor
            textView.delegate = self
            textView.text = "Enter meal description"
            textView.textColor = UIColor.placeholderText
        }
        
        // UITextViewDelegate methods to customize behavior of meal description text view
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
        
        // Action for changing meal picture
        @IBAction func changePictureButton3(_ sender: Any) {
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.allowsEditing = true
            present(vc, animated: true)
        }
        
        // Function to save meal data to UserDefaults
        func saveData() {
            UserDefaults.standard.set(meal3NameTextField.text, forKey: "mealName3")
            UserDefaults.standard.set(mealDescription3.text, forKey: "mealDescription3")
            if let imageData = mealPicture3.image?.pngData() {
                UserDefaults.standard.set(imageData, forKey: "mealPicture3")
            }
        }
        
        // Function to load saved meal data from UserDefaults
        func loadSavedData() {
            if let mealName = UserDefaults.standard.string(forKey: "mealName3") {
                meal3NameTitle.text = mealName
                meal3NameTextField.text = mealName
            }
            if let mealDescription = UserDefaults.standard.string(forKey: "mealDescription3") {
                mealDescription3.text = mealDescription
            }
            if let imageData = UserDefaults.standard.data(forKey: "mealPicture3") {
                mealPicture3.image = UIImage(data: imageData)
            }
        }
    }

    // Extension for handling image picker controller delegate methods
    extension CustomMenu3ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let editedImage = info[.editedImage] as? UIImage {
                mealPicture3.image = editedImage
                saveData() // Save the image here
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }

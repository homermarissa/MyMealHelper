//
//  ProfileViewController.swift
//  MyMealPlanner
//
//  Created by Marissa Homer on 2/1/24.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var personalGoalsTextView: UITextView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profilePicture.roundedImage()
        mealDescriptionTextViewFunctionality(personalGoalsTextView)
        loadUserData()
        personalGoalsTextView.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        //The placeholder text will be shown only if there is no existing text
        if personalGoalsTextView.text == "What are your personal goals?" {
                personalGoalsTextView.text = "What are your personal goals?"
                personalGoalsTextView.textColor = UIColor.placeholderText
            } else {
                personalGoalsTextView.textColor = UIColor.black
            }
    }
    
    func saveUserData() {
            if let imageData = profilePicture.image?.pngData() {
                UserDefaults.standard.set(imageData, forKey: "profilePictureData")
            }
            UserDefaults.standard.set(firstNameTextField.text, forKey: "firstName")
            UserDefaults.standard.set(lastNameTextField.text, forKey: "lastName")
            UserDefaults.standard.set(personalGoalsTextView.text, forKey: "personalGoals")
        }
        
        func loadUserData() {
            if let imageData = UserDefaults.standard.data(forKey: "profilePictureData"),
               let image = UIImage(data: imageData) {
                profilePicture.image = image
            }
            if let firstName = UserDefaults.standard.string(forKey: "firstName") {
                firstNameTextField.text = firstName
            }
            if let lastName = UserDefaults.standard.string(forKey: "lastName") {
                lastNameTextField.text = lastName
            }
            if let personalGoals = UserDefaults.standard.string(forKey: "personalGoals") {
                personalGoalsTextView.text = personalGoals
            }
        }
    
    @IBAction func changeProfilePictureButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                imagePickerController.allowsEditing = true
                present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func mealDescriptionTextViewFunctionality(_ textView: UITextView){
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.systemGray6.cgColor
        textView.delegate = self
        textView.text = "What are your personal goals?"
        textView.textColor = UIColor.placeholderText
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.placeholderText {
                textView.text = ""
                textView.textColor = UIColor.black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "What are your personal goals?"
                textView.textColor = UIColor.placeholderText
            }
            saveUserData()
        }
        
        // MARK: - UITextFieldDelegate
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            saveUserData()
        }
        
        // MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let editedImage = info[.editedImage] as? UIImage {
                profilePicture.image = editedImage
                saveUserData()
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    


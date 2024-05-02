//
//  CustomMenuViewController.swift
//  MyMealPlanner
//
//  Created by Marissa Homer on 2/6/24.
//

import UIKit

class CustomMenuViewController: UIViewController , UITextViewDelegate {
    
    @IBOutlet weak var mealDescription1: UITextView!
    
    @IBOutlet weak var mealPicture1: UIImageView!
    
    @IBOutlet weak var mealNameTitle: UILabel!
    
    @IBOutlet weak var mealNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mealDescriptionTextViewFunctionality(mealDescription1)
        loadMealData()
        if mealDescription1.text == "Enter meal description" {
                mealDescription1.text = "Enter meal description"
                mealDescription1.textColor = UIColor.placeholderText
            } else {
                mealDescription1.textColor = UIColor.black
            }
    }
    @IBAction func editingDidEndMealName(_ sender: Any) {
        mealNameTitle.text = mealNameTextField.text
        saveMealData()
    }
    @IBAction func nextPageButton(_ sender: Any) {
        performSegue(withIdentifier: "meal2Page", sender: self)
    }
    
    
    @IBAction func changePictureButton1(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func mealDescriptionTextViewFunctionality(_ textView: UITextView){
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.systemGray6.cgColor
        textView.delegate = self
        textView.text = "Enter meal description"
        textView.textColor = UIColor.placeholderText
        
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
            saveMealData()
        }
    
    func loadMealData() {
            if let mealName = UserDefaults.standard.string(forKey: "mealName") {
                mealNameTextField.text = mealName
                mealNameTitle.text = mealName
            }
            if let mealDescription = UserDefaults.standard.string(forKey: "mealDescription") {
                mealDescription1.text = mealDescription
            }
            if let imageData = UserDefaults.standard.data(forKey: "mealImageData") {
                if let image = UIImage(data: imageData) {
                    mealPicture1.image = image
                }
            }
        }

        func saveMealData() {
            UserDefaults.standard.set(mealNameTextField.text, forKey: "mealName")
            UserDefaults.standard.set(mealDescription1.text, forKey: "mealDescription")
            if let imageData = mealPicture1.image?.pngData() {
                UserDefaults.standard.set(imageData, forKey: "mealImageData")
            }
        }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CustomMenuViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            mealPicture1.image = editedImage
            saveMealData()
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

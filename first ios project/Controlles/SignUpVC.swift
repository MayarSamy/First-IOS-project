//
//  SignUpVC.swift
//  first ios project
//
//  Created by IOS on 7/27/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    // MARK: - outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    // MARK: -  variabels
    var gender = Gender.female
    let imagePicker = UIImagePickerController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //title
        self.navigationItem.title = "Register"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
  
    
    //image choosing
    @IBAction func imagePickerBtnTapped(_ sender: UIButton) {
        present(imagePicker, animated: true)
    }
    
    //address 
    @IBAction func addressBtnTapped(_ sender: UIButton) {
                let MapVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapVC") as! MapVC
                    MapVC.delegate = self
                navigationController?.pushViewController(MapVC, animated: true)
    }
    
    //gender switch
    @IBAction func genderSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            gender = .female
        } else {
            gender = .male
        }
    }
    
    // MARK: - rigester
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        
        if (dataEntered())
        {
            if(isValidData()) {
                SQLManager.shared().createUsersTable()
                let image = CodableImage.setImage(image: imageView.image!) //UserDefaultManager.shared().setImage(imageView!.image)
                let user = User(image: image, name: userNameTextField.text!, email: emailTextField.text!, phone: phoneNumberTextField.text!, address: addressTextField.text!, password: passwordTextField.text!, gender: Gender(rawValue: gender.rawValue))
//              SQLManager.shared().insertUser(name: userNameTextField.text!, email: emailTextField.text!, phone: phoneNumberTextField.text!, address: addressTextField.text!, password: passwordTextField.text!, gender: gender.rawValue)
                SQLManager.shared().insertUser(userData: user)
                UserDefaultManager.shared().email = emailTextField.text!
                
                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                navigationController?.pushViewController(loginVC, animated: true)
            }
        }
    }
   
    
    //checking data entered
    private func dataEntered() -> Bool {
        
        // MARK: - checking user name entered
        guard let name = userNameTextField.text , name.count > 0 else {
            let alert = UIAlertController(title: "ERROR", message: "Enter your name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        
        // MARK: - checking email entered
        guard let email = emailTextField.text , email.count > 0 else {
            let alert = UIAlertController(title: "ERROR", message: "Enter your email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        
        // MARK: - checking phone entered
        guard let phone = phoneNumberTextField.text , phone.count > 0 else {
            let alert = UIAlertController(title: "ERROR", message: "Enter your phone number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        
        // MARK: - checking address entered
        guard let address = addressTextField.text , address.count > 0 else {
            let alert = UIAlertController(title: "ERROR", message: "Enter your address", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
         
            return false
        }
        
        // MARK: - checking password entered
        guard let password = passwordTextField.text , password.count > 0 else {
            let alert = UIAlertController(title: "ERROR", message: "Password must be at least 8 digits", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        
        // MARK: - checking repassword entered
        guard let repassword = rePasswordTextField.text , repassword == passwordTextField.text else {
            let alert = UIAlertController(title: "ERROR", message: "Password does not match ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        return true
    }
    

    //validating data
    func isValidData() -> Bool{
        guard isValidEmail(emailTextField.text!) else {
            let alert = UIAlertController(title: "ERROR", message: "Enter valid email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        guard isValidPhone(phoneNumberTextField.text!) else {
            let alert = UIAlertController(title: "ERROR", message: "Enter valid phone number", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        guard isValidPassword(passwordTextField.text!) else {
            let alert = UIAlertController(title: "ERROR", message: "Password must contain at least 6 digits , one Character and one Special Character", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    //valid email
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //valid phone
    func isValidPhone(_ phone: String) -> Bool {
        let phoneRegEx = "^\\d{3}\\d{3}\\d{5}$"
        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: phone)
    }
    
    //valid password
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,16}"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}



extension SignUpVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension SignUpVC : SetAddressDelegate
{
    func setAddress(_ address: String) {
        addressTextField.text = address
    }
}




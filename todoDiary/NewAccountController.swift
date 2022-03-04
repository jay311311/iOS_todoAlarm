//
//  NewAccountController.swift
//  todoDiary
//
//  Created by Jooeun Kim on 2022/03/04.
//

import UIKit
import Firebase


class NewAccountController: UIViewController {

    @IBOutlet weak var TextFieldBox: UIView!
    
    @IBOutlet weak var IdTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var idErrorMessage: UILabel!
    @IBOutlet weak var passwordErrorMessage: UILabel!
    @IBOutlet weak var nameErrorMessage: UILabel!
    
    var validationPassword :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextFieldBox.layer.cornerRadius=30
        idErrorMessage.text = ""
        passwordErrorMessage.text = ""
        nameErrorMessage.text=""
        
        signUpBtn.addTarget(self, action: #selector(touchSignup), for: .touchUpInside)
    }
    
    
    
   
    @IBAction func checkValidationPassword(_ sender: UITextField) {
        
        guard let password = PasswordTextField.text else { return }
        let rexPassword = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        if rexPassword.evaluate(with: password) {
            PasswordTextField.layer.borderColor = UIColor.green.cgColor
            PasswordTextField.layer.borderWidth = 0.25
            PasswordTextField.layer.cornerRadius = 5.0
            passwordErrorMessage.textColor = UIColor.red
            passwordErrorMessage.text = ""
            validationPassword = password
        }else{
            PasswordTextField.layer.borderColor = UIColor.red.cgColor
            PasswordTextField.layer.cornerRadius = 5.0
            PasswordTextField.layer.borderWidth = 0.25
            passwordErrorMessage.textColor = UIColor.red
            passwordErrorMessage.text = "최소 6자 이상 & 영어 대소문자,숫자,특수기호를 포함하여주세요"
        }
        
    }
    
    
    
    @objc func touchSignup(){
        guard let email =  IdTextField.text, let password =  PasswordTextField.text  else {
           return  print("정보를 빠짐없이 기입해 주세요")
        }
        
        Auth.auth().createUser(withEmail:email, password: password) { authResult, error in
            if authResult != nil {
                print("signup success")
            }else{
                print("signup fail---> \(error?.localizedDescription)")

            }
        }
    }
    


}

struct User {
    
}

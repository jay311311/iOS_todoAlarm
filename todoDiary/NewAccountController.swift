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
    
    var validationId : String = ""
    var validationPassword :String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextFieldBox.layer.cornerRadius=30
        idErrorMessage.text = ""
        passwordErrorMessage.text = ""
        nameErrorMessage.text=""
        
        signUpBtn.addTarget(self, action: #selector(touchSignup), for: .touchUpInside)
    }
    
    
    @IBAction func checkValidationId(_ sender: Any) {
        IdTextField.layer.cornerRadius = 5.0
        
        guard let id = IdTextField.text else { return }
        let rexId = NSPredicate(format: "SELF MATCHES %@ ", "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,8}$")
        if rexId.evaluate(with: id){
            IdTextField.layer.borderColor = UIColor.green.cgColor
            IdTextField.layer.borderWidth = 0.25
            idErrorMessage.text = ""
            validationId = id
        }else{
            IdTextField.layer.borderColor = UIColor.red.cgColor
            IdTextField.layer.borderWidth = 0.25
            idErrorMessage.textColor = UIColor.red
            idErrorMessage.text = "* 이메일형식을 확인해주세요"
        }
        
    }
    
    
    @IBAction func checkValidationPassword(_ sender: UITextField) {
        PasswordTextField.layer.cornerRadius = 5.0
        
        guard let password = PasswordTextField.text else { return }
        let rexPassword = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        if rexPassword.evaluate(with: password) {
            PasswordTextField.layer.borderColor = UIColor.green.cgColor
            PasswordTextField.layer.borderWidth = 0.25
            passwordErrorMessage.text = ""
            validationPassword = password
        }else{
            PasswordTextField.layer.borderColor = UIColor.red.cgColor
            PasswordTextField.layer.borderWidth = 0.25
            passwordErrorMessage.textColor = UIColor.red
            passwordErrorMessage.text = "* 최소 6자 이상 & 영어 대소문자,숫자,특수기호를 포함하여주세요"
        }
        
    }
    
    @IBAction func checkName(_ sender: Any) {
        
        NameTextField.layer.borderColor = UIColor.green.cgColor
        NameTextField.layer.borderWidth = 0.25
        NameTextField.layer.cornerRadius = 5.0
        nameErrorMessage.textColor = UIColor.red
        nameErrorMessage.text = ""
    }
    
    
    @objc func touchSignup(){
        Auth.auth().createUser(withEmail:validationId, password: validationPassword) { authResult, error in
                        if authResult != nil {
                            print("signup success")
                        }else{
                            print("signup fail---> \(error?.localizedDescription)")
                        }
                    }
    }
//        if validationId.count <= 0 || validationPassword.count <= 0 ||
//            NameTextField.text?.isEmpty != nil {
//
//            let alert =   UIAlertController(title: "알림", message: "정보를 기입해 주세요", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "확인", style:.default , handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            NameTextField.layer.borderColor = UIColor.red.cgColor
//            NameTextField.layer.borderWidth = 0.25
//            nameErrorMessage.textColor = UIColor.red
//            nameErrorMessage.text = "* 이름을 입력하여 주세요"
//        }else{
//
//        }
//    }
}



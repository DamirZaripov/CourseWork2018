//
//  SignUpNameViewController.swift
//  CourseWork
//
//  Created by Damir Zaripov on 06/11/2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

import UIKit
import Alamofire

class SignUpLoginViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            self.nameTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func onNextButtonPressed(_ sender: Any) {
        if self.nameTextField.text == "" {
            let alert = AlertFactory.shared.createAlert(title: "Некорректный логин", message:  "Логин не может быть пустым")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if let login = self.nameTextField.text?.trimmingCharacters(in: .whitespaces) {
            NetworkManager.shared.isLoginAlreadyUseRequest(with: login, complitionBlock: { (result) in
                if (result) {
                    let alert = AlertFactory.shared.createAlert(title: "Логин уже используется", message:  "Данный логин принадлежит другому пользователю")
                    self.present(alert, animated: true, completion: nil)
                    return
                } else {
                    RequestManager.instance.login = login
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "SignUpPasswordViewController") as! SignUpPasswordViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }) { (error) in
                let alert = AlertFactory.shared.createAlert(title: "Проблемы с подключением", message: "Проверьте интернет-соединение")
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension SignUpLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.onNextButtonPressed(textField)
        return true
    }
}

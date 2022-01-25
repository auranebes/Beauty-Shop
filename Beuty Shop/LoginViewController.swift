//
//  LoginViewController.swift
//  Beuty Shop
//
//  Created by Arslan Abdullaev on 25.01.2022.
//

//реализовать пост метод для номера телефона в тф
//вывод алерта что данные отправились
//на authvc сохранить данные через userDefaults и передать в ProfileVC делегированием 

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginButtonPressed() {
        
        
        
        let data = User(phoneNumber: loginTF.text,
                        nickName: "nil",
                        email: "nil",
                        firstName: "nil")
        postUserData(with: data)
        performSegue(withIdentifier: "showAuth", sender: nil)
    }
    
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    private func postUserData(with data: User){
        NetworkManager.shared.postRequestPhoneNumber(with: data, to: NetworkManager.shared.postRequest) { result in
            switch result {
            case .success(let phone):
                print(phone)
                self.successAlert()
            case .failure(let error):
                print(error)
                self.failedAlert()
            }
        }
    }
    

}
extension LoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    view.endEditing(true)
    }
        
    // MARK: - Alert Controller
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "Your phone number succesfully added",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    

}

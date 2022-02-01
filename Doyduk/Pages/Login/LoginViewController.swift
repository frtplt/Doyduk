//
//  LoginViewController.swift
//  Doyduk
//
//  Created by Firat on 1.02.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var TableNoTextField: UITextField!
    @IBOutlet weak var LoginNameTextField: UITextField!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginNameTextField.text = userDefaults.string(forKey: "name")
        TableNoTextField.text = userDefaults.string(forKey: "tableNo")

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func girisYapButtonPressed(_ sender: UIButton) {
        if LoginNameTextField.text == "" {
            showAlert(message: "İsim Giriniz")
        }
        else if TableNoTextField.text == "" {
            showAlert(message: "Masa No Giriniz")
        }
        else{
            userDefaults.set(LoginNameTextField.text, forKey: "name")
            userDefaults.set(TableNoTextField.text, forKey: "tableNo")
            
            performSegue(withIdentifier: "toCategoryPage", sender: self)
        }
    }
    func showAlert(message: String){
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCategoryPage" {
            let desVC = segue.destination as! CategoryViewController
            desVC.categoriesTitle = "\(LoginNameTextField.text!), \(TableNoTextField.text!)"
        }
    }
    
    
    
    
    
    
}

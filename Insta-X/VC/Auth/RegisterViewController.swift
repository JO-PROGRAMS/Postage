//
//  ViewController.swift
//  Insta-X
//
//  Created by Youssef Osama on 09/11/2020.
//

import SwiftyJSON
import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var phoneKeyTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var mailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var passConfTxt: UITextField!
    @IBOutlet weak var selectImageImageView: UIImageView!
    
    var userImage: UIImage?
    
    var countries = [CountriesModelElement]() {
        didSet {
            countryPicker.reloadComponent(1)
        }
    }
    
    var countryPicker = UIPickerView()
    
    var selectedCountryId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // long tap
        // number of taps
        let geasture = UITapGestureRecognizer(target: self, action: #selector(didTapOnImageView))
        selectImageImageView.addGestureRecognizer(geasture)
        getCountries()
        countryPicker.delegate = self
        countryPicker.dataSource = self
        phoneKeyTxt.inputView = countryPicker
        
        // Picker Tool Bar With Cancel Button
        // Grasture On View To Dismiss KeyBoard
    }
    
    @objc func didTapOnImageView() {
        print("didTapOnImageView")
        // open image picker ( Galary )
        // then ( userImage <- selectedImage )
    }
    
    func getCountries() {
        let url = Constants.baseUrl + "countries"
        
        let request = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
        
        request.responseJSON { (response) in
            if let data = response.data {
                print(JSON(data))
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(CountriesModel.self, from: data) {
                    self.countries = model.data ?? []
                }
            }
        }
    }
    
    @IBAction func register(_ sender: Any) {
        // validate user Input
        
        guard let userImage = userImage else {
            showAlert(title: "Error", message: "Enter Valid Profile Image")
            return
        }
        
        guard let userName = usernameTxt.text, !userName.isEmpty else {
            showAlert(title: "Error", message: "Enter Valid Name")
            return
        }
        
        guard let userMail = mailTxt.text, !userMail.isEmpty else {
            showAlert(title: "Error", message: "Enter Valid Mail")
            return
        }
        
        guard let userPhone = phoneTxt.text, userPhone.count > 4 else {
            showAlert(title: "Error", message: "Enter Valid Phone")
            return
        }
        
        guard let selectedCountryId = selectedCountryId else {
            showAlert(title: "Error", message: "Enter Valid Phone")
            return
        }
        
        guard let userPass = passTxt.text, userPass.count > 4 else {
            showAlert(title: "Error", message: "Enter Valid Password")
            return
        }
        
        guard let userConfPass = passConfTxt.text, userConfPass == userPass else {
            showAlert(title: "Error", message: "Your Passwords Are Not The Same")
            return
        }
        
        // create body
        
        let body = [
            "username": userName,
            "password": userPass,
            "email": userMail,
            "mobile": userPhone,
            "country_id": selectedCountryId,
        ] as [String : Any]
        
        
        // call api
        
        let registerUrl = Constants.baseUrl + "signup"
        
        Network.upload(LoginModel.self, url: registerUrl, body: body, imageToUpload: userImage) { (response) in
            self.handleApiResonse(loginModel: response)
        }
    }
    
    func handleApiResonse(loginModel: LoginModel) {
        if loginModel.status == "error" {
            showAlert(title: "error", message: loginModel.message ?? "")
        } else if loginModel.status == "success" {
            showAlert(title: "success", message: loginModel.message ?? "")
        }
    }
    
    @IBAction func getCode(_ sender: Any) {
        let storyboard = UIStoryboard(name: "GetCode", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "UIGetCodeViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        phoneKeyTxt.text = countries[row].dialCode
        selectedCountryId = countries[row].id
    }
}

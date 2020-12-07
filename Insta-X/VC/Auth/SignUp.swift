//
//  SignUp.swift
//  Insta-X
//
//  Created by Youssef Osama on 15/11/2020.
//What happened here?
//



import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class SignUp: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Pass: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var PassConf: UITextField!
    @IBOutlet weak var dialCode: UITextField!
    @IBOutlet var theScreen: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBAction func AcceptButt(_ sender: Any) {
        
    }
    
    
    var loader = NVActivityIndicatorView(frame: .init(x: 0, y: 0, width: 150, height: 150), type: .orbit, color: #colorLiteral(red: 0.2998352051, green: 0.2986930907, blue: 0.9962851405, alpha: 1))
    
    var picker = UIPickerView()
    
    var imagePicker = UIImagePickerController()
    
    var userImage: UIImage?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profilePic.image = image
            userImage = image
        }
        
    }
    
    var countries: [CountryModelData] = [] {
        didSet {
            picker.reloadComponent(1)
        }
    }
    
    @objc func donePicker() {
        view.endEditing(true)
    }
    
    var countryID : Int = 1
    
    func getCountries () {
        
        Network.Request(CountriesModel.self, url: "https://alfreeej-store.com/insta/api/countries") { (country) in
             self.countries = country.data ?? []
            
            print(self.countries)
        } onFailure: { (error) in
            self.showAlert(title: "Error", message: error)
        }

    }
    
    @IBAction func LoginButton(_ sender: Any) {
        
        
        

        
        guard let userImage = userImage else {
            
            showAlert(title: "Invalid User Image", message: "Must Select Your Image")
            
            return
        }
        
        
        guard let username = Username.text, username.count >= 4 else {
            
            showAlert(title: "Invalid Username", message: "Must be more than 4 characters")
            
            return
        }
        
        guard let phone = Phone.text, phone.count > 4 else {
            
            showAlert(title: "Invalid Phone Number", message: "Phone number must be atleast 4 numbers")
            
            return
        }
        
        guard let email = emailTxt.text, email.count > 6, email.contains("@") else {
            showAlert(title: "Invalid Email", message: "Enter a valid Email")
            return
        }
        
        
        guard let pass = Pass.text, pass.count >= 5 else {
            
            showAlert(title: "Invalid Password", message: "Password must be atleast 5 characters")
            
            return
        }
        
        guard let passconf = PassConf.text, passconf == pass else {
            
            showAlert(title: "Invalid Password", message: "Password are not the same")
            
            return
        }
        
        
        let body: [String: Any] = [
            "username": username,
            "password": pass,
            "email": email,
            "mobile": phone,
            "device_type" : "ios",
            "fcm_token" : "Not Available",
            "country_id": countryID
        ]
        
        
        
        
        print(JSON(body))
        
        view.addSubview(loader)
        loader.center = view.center
        loader.startAnimating()
       
        
        let url = "https://alfreeej-store.com/insta/api/signup"
        
        Network.network.upload(SignInModel.self, url: url, userImage: userImage, body: body, method: .post) { (model) in
            self.handleRespnse(Model: model)
            self.loader.stopAnimating()
            self.loader.isHidden = true
        } onFailure: { (error) in
            self.showAlert(title: "Error", message: error)
            self.loader.stopAnimating()
            self.loader.isHidden = true
        }
    }

    
    
    
    
    @objc func Press(_ sender: UILongPressGestureRecognizer) {
        print("hello world")
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello")
        // Do any additional setup after loading the view.
        
        
        Username.addPadding(padding: .left(10))
        Phone.addPadding(padding: .left(10))
        Pass.addPadding(padding: .left(15))
        PassConf.addPadding(padding: .left(10))
        emailTxt.addPadding(padding: .left(10))
        
        var viewGesture = UITapGestureRecognizer(target: self, action: #selector(self.donePicker))
        
        var gesture = UITapGestureRecognizer(target: self, action: #selector(Press(_:)))
        profilePic.addGestureRecognizer(gesture)
        
        theScreen.addGestureRecognizer(viewGesture)
        
        getCountries()
        
        picker.dataSource = self
        picker.delegate = self
        
       
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .blue
        toolBar.sizeToFit()
        

        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        
        toolBar.setItems([cancelButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        dialCode.inputAccessoryView = toolBar
        dialCode.inputView = picker
    }
    
}


extension SignUp: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        countries[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dialCode.text = countries[row].dialCode
        
        countryID = countries[row].id
    }
    


    func handleRespnse(Model: SignInModel) {
        if Model.status == "error" {
            showAlert(title: Model.status, message: Model.message)
        } else {
            //            showAlert(title: Model.status, message: Model.message)
            let email = Model.data.email
            let storyboard = UIStoryboard(name: "AuthSB", bundle: .main)
            let vc = storyboard.instantiateViewController(identifier: "EnterCode") as! EnterCode
            vc.email = email
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
    


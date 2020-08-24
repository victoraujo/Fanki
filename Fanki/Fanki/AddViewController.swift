//
//  AddViewController.swift
//  Fanki
//
//  Created by Victor Vieira on 18/08/20.
//  Copyright © 2020 Victor Vieira. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var wordField: UITextField!
    @IBOutlet var translationField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!

    public var completion: ((String,String,Date) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordField.delegate = self
        translationField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        
    }
    
    @objc func didTapSaveButton(){
        if let wordText = wordField.text, !wordText.isEmpty,
            let translationText = translationField.text, !translationText.isEmpty{
            let targetDate = datePicker.date
            completion?(wordText, translationText, targetDate)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

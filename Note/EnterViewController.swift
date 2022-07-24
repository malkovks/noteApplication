//
//  EnterViewController.swift
//  Note
//
//  Created by Константин Малков on 27.05.2022.
//

import UIKit

class EnterViewController: UIViewController {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!
    
    public var completion: ((String,String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    @objc func didTapSave() {
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
            completion?(text, noteField.text)
            
        } else {
            let alert = UIAlertController(title: "Empty fields!", message: "Enter text in textfields!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Another one", style: .default))
            present(alert, animated: true)
        }
        
    }
}

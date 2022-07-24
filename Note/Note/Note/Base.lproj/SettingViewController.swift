//
//  SettingViewController.swift
//  Note
//
//  Created by Константин Малков on 28.05.2022.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet public var label: UILabel!
    
    public var changeFontSize: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sliderSettingFont(_ sender: UISlider){
        let curValue = CGFloat(sender.value)
//        label.text = String(curValue)
        label.font = UIFont(name: "times new roman", size: curValue)
        
    }
    
    @IBAction func saveButton() {
        if let font = label.text, !font.isEmpty {
            changeFontSize?(font)
        }
    }
    
    
}

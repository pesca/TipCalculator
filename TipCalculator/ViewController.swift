//
//  ViewController.swift
//  TipCalculator
//
//  Created by Philip Pesca on 12/18/17.
//  Copyright © 2017 Philip Pesca. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField?
    @IBOutlet var billLabel: UILabel?
    @IBOutlet var totalLabel: UILabel?
    @IBOutlet var tipLabel: UILabel?
    @IBOutlet var percentSegmentControl: UISegmentedControl?
    
    var percent: Int = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let featureSettings = [UIFontFeatureTypeIdentifierKey: kNumberSpacingType, UIFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector]
        let attributes = [UIFontDescriptorFeatureSettingsAttribute: [featureSettings]]
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFontTextStyle.body).addingAttributes(attributes)
        let numbersFont = UIFont(descriptor: fontDescriptor, size: 0.0)
        
        tipLabel?.font = numbersFont
        billLabel?.font = numbersFont
        totalLabel?.font = numbersFont
        
        textField?.becomeFirstResponder()
        textField?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clear(_ sender: UIBarButtonItem) {
        textField?.text = nil
        editingChanged(textField!)
    }
    
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            percent = 10
        case 1:
            percent = 15
        default:
            percent = 20
        }
        
        editingChanged(textField!);
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        let bill = Int(sender.text!) ?? 0
        let tip = bill * percent / 100
        billLabel?.text = format(num: bill)
        tipLabel?.text = format(num: tip)
        totalLabel?.text = format(num: tip + bill)
    }
    
    func format(num: Int) -> String {
        var str = String(num)
        let len = str.lengthOfBytes(using: String.Encoding.ascii)
        
        if len == 1 {
            str = "00\(str)"
        }
        else if len == 2 {
            str = "0\(str)"
        }
        
        str.insert(".", at: str.index(str.endIndex, offsetBy: -2))
        return "$\(str)"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textLen = textField.text?.lengthOfBytes(using: String.Encoding.ascii)
        let stringLen = string.lengthOfBytes(using: String.Encoding.ascii)
        return (textLen! + stringLen - range.length) <= 8
    }
}


//
//  ViewController.swift
//  TipCalculator
//
//  Created by Philip Pesca on 12/18/17.
//  Copyright © 2017 Philip Pesca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textField: UITextField?
    @IBOutlet var billLabel: UILabel?
    @IBOutlet var totalLabel: UILabel?
    @IBOutlet var tipLabel: UILabel?
    @IBOutlet var percentSegmentControl: UISegmentedControl?
    
    var percent: Int = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bodyFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFontTextStyle.body)
        let bodyMonospacedNumbersFontDescriptor = bodyFontDescriptor.addingAttributes(
            [
                UIFontDescriptorFeatureSettingsAttribute: [
                    [
                        UIFontFeatureTypeIdentifierKey: kNumberSpacingType,
                        UIFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector
                    ]
                ]
            ])
        let bodyMonospacedNumbersFont = UIFont(descriptor: bodyMonospacedNumbersFontDescriptor, size: 0.0)
        tipLabel?.font = bodyMonospacedNumbersFont
        billLabel?.font = bodyMonospacedNumbersFont
        totalLabel?.font = bodyMonospacedNumbersFont
        
        textField?.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let tip = bill / percent
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
}


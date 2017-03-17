//
//  ViewController.swift
//  Calculator
//
//  Created by Prafull Kumar Soni on 6/21/16.
//  Copyright © 2016 pksprojects. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        return formatter
    }()

    @IBOutlet weak var display: UILabel!
    var isTyping = false
    var isFloat = false
    
    private var calculatorBrain = CalculatorBrain()
    
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = newValue == floor(newValue) ? String(format: "%.0f", newValue) : String(newValue)
        }
    }
  
    @IBAction func digitPressed(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if isTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else{
            display.text = digit
        }
        isTyping = true
    }
    
    @IBAction func addDecimalPoint(_ sender: UIButton) {
        if !isFloat{
            let point = sender.currentTitle!
            display.text = display.text! + point
            isFloat = true
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        if isTyping{
            calculatorBrain.set(operand: displayValue)
        }
        isTyping = false
        isFloat = false
        if let mathematicalSymbol = sender.currentTitle{
            calculatorBrain.perform(operation: mathematicalSymbol)
        }
        displayValue = calculatorBrain.result
    }
}


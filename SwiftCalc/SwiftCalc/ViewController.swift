//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Zach Zeleznick on 9/20/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Width and Height of Screen for Layout
    var w: CGFloat!
    var h: CGFloat!
    

    // IMPORTANT: Do NOT modify the name or class of resultLabel.
    //            We will be using the result label to run autograded tests.
    // MARK: The label to display our calculations
    var resultLabel = UILabel()
    
    // TODO: This looks like a good place to add some data structures.
    //       One data structure is initialized below for reference.
    var operation = ""
    var isTypingNumber = false
    var firstNumberString = ""
    var secondNumberString = ""
    var enteredButtons: [String] = []
    var newOperation = true
    var middleOfOperation = false
    var containsDecimal = false
    var toReturn = ""
    var intResult = 0
    var doubleResult = 0.0
    var newCalc = true
    var numberCount = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        w = view.bounds.size.width
        h = view.bounds.size.height
        navigationItem.title = "Calculator"
        // IMPORTANT: Do NOT modify the accessibilityValue of resultLabel.
        //            We will be using the result label to run autograded tests.
        resultLabel.accessibilityValue = "resultLabel"
        makeButtons()
        // Do any additional setup here.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: A method to update your data structure(s) would be nice.
    //       Modify this one or create your own.
    func updateSomeDataStructure(_ content: String) {
        print("Update me like one of those PCs")
        if newOperation {
            enteredButtons = []
            //enteredButtons[0] = Int(content)!
        } else {
            //enteredButtons[1] = Int(content)!
        }
    }
    
    // TODO: Ensure that resultLabel gets updated.
    //       Modify this one or create your own.
    func updateResultLabel(_ content: String) {
        print("Update me like one of those PCs")
        if isTypingNumber {
            resultLabel.text = resultLabel.text! + content
        } else {
            resultLabel.text = content
            isTypingNumber = true
        }
    }
    
    
    // TODO: A calculate method with no parameters, scary!
    //       Modify this one or create your own.
    func calculate() -> String {
        return "0"
    }
    
    // TODO: A simple calculate method for integers.
    //       Modify this one or create your own.
    func intCalculate(a: Int, b:Int, operation: String) -> Int {
        print("Calculation requested for \(a) \(operation) \(b)")
        
        if (operation == "+") {
            intResult = a + b
           
        } else if (operation == "-") {
            intResult = a - b
            
        } else if (operation == "*") {
            
            intResult = a * b
            
        } else if (operation == "/") {
            intResult = a/b
            
        }
        return intResult
    }
    
    // TODO: A general calculate method for doubles
    //       Modify this one or create your own.
    func calculate(a: String, b:String, operation: String) -> Double {
        print("Calculation requested for \(a) \(operation) \(b)")
        if (operation == "+") {
            doubleResult = Double(a)! + Double(b)!
        } else if (operation == "-") {
            doubleResult = Double(a)! - Double(b)!
        } else if (operation == "*") {
            doubleResult = Double(a)! * Double(b)!
        } else if (operation == "/") {
            doubleResult = Double(a)! / Double(b)!
        }
        return doubleResult
    }
    
    // REQUIRED: The responder to a number button being pressed.
    func numberPressed(_ sender: CustomButton) {
        guard Int(sender.content) != nil else { return }
        print("The number \(sender.content) was pressed")
        // Fill me in!
        if (numberCount < 7) {
            let number = sender.currentTitle
            updateResultLabel(number!)
            
            isTypingNumber = true
            numberCount += 1
            
        }
        
    }
    
    // REQUIRED: The responder to an operator button being pressed.
    func operatorPressed(_ sender: CustomButton) {
        // Fill me in!
        print("The operator \(sender.content) was pressed")
        if (sender.content == "=") {
            middleOfOperation = false
            isTypingNumber = false
            secondNumberString = resultLabel.text!
            if (firstNumberString.contains(".")) {
                print(firstNumberString)
                print(secondNumberString)
                
                doubleResult = calculate(a:firstNumberString, b:secondNumberString, operation:operation)
                print(doubleResult)
                updateResultLabel(String(doubleResult))
                firstNumberString = String(doubleResult)
                secondNumberString = ""
                
            } else {
                print(firstNumberString)
                print(secondNumberString)
                if (operation == "*" || operation == "/") {
                    if (Int(firstNumberString)! % Int(secondNumberString)! != 0) {
                        doubleResult = calculate(a:firstNumberString, b:secondNumberString, operation:operation)
                        print(doubleResult)
                        updateResultLabel(String(doubleResult))
                        firstNumberString = String(doubleResult)
                        secondNumberString = ""
                    } else {
                        intResult = intCalculate(a:Int(firstNumberString)!,  b:Int(secondNumberString)!, operation:operation)
                        print(intResult)
                        updateResultLabel(String(intResult))
                        firstNumberString = String(intResult)
                        secondNumberString = ""
                    }
                } else {
                    intResult = intCalculate(a:Int(firstNumberString)!,  b:Int(secondNumberString)!, operation:operation)
                    print(intResult)
                    updateResultLabel(String(intResult))
                    firstNumberString = String(intResult)
                    secondNumberString = ""
                }
            
            }
            isTypingNumber = false
            newCalc = true
            numberCount = 0
        } else if (sender.content == "C") {
            isTypingNumber = false
            middleOfOperation = false
            intResult = 0
            doubleResult = 0.0
            if (firstNumberString.contains(".")) {
                updateResultLabel("0.0")
            } else {
                updateResultLabel("0")
            }
            firstNumberString = resultLabel.text!
            isTypingNumber = false
            numberCount = 0
        } else if (sender.content == "+/-") {
            isTypingNumber = false
            if (resultLabel.text!.contains(".")) {
                var signedDouble = Double(resultLabel.text!)
                signedDouble! *= -1.0
                updateResultLabel(String(describing:signedDouble))
            } else {
                
                let signedInt = Int(resultLabel.text!)! * -1
                updateResultLabel(String(describing:signedInt))
            }
            
            //firstNumberString = resultLabel.text!
        }
        else {
            isTypingNumber = false
            if (middleOfOperation == true) {
                secondNumberString = resultLabel.text!
                if (firstNumberString.contains(".")) {
                    print(firstNumberString)
                    print(secondNumberString)
                    doubleResult = calculate(a:firstNumberString, b:secondNumberString, operation:operation)
                    print(doubleResult)
                    updateResultLabel(String(doubleResult))
                    firstNumberString = String(doubleResult)
                    secondNumberString = ""
                } else {
                    print(firstNumberString)
                    print(secondNumberString)
                    if (/*operation == "*" || */operation == "/") {
                        if (Int(firstNumberString)! % Int(secondNumberString)! != 0) {
                            doubleResult = calculate(a:firstNumberString, b:secondNumberString, operation:operation)
                            print(doubleResult)
                            updateResultLabel(String(doubleResult))
                            firstNumberString = String(doubleResult)
                            secondNumberString = ""
                        }
                    } else {
                        intResult = intCalculate(a:Int(firstNumberString)!, b:Int(secondNumberString)!, operation:operation)
                        print(intResult)
                        updateResultLabel(String(intResult))
                        firstNumberString = String(intResult)
                        secondNumberString = ""
                    }
                   /* //if secondNumberString != ""
                    intResult = intCalculate(a:Int(firstNumberString)!, b:Int(secondNumberString)!, operation:operation)
                    print(intResult)
                    updateResultLabel(String(intResult))
                    firstNumberString = String(intResult)
                    secondNumberString = ""*/


                }
                isTypingNumber = false
                operation = sender.content
            }
            else {
                isTypingNumber = false
                middleOfOperation = true
                firstNumberString = resultLabel.text!
                print(firstNumberString)
                isTypingNumber = false
                operation = sender.content
            }
            numberCount = 0
        }
        
        
        
    }
    
    // REQUIRED: The responder to a number or operator button being pressed.
    func buttonPressed(_ sender: CustomButton) {
        print("The button \(sender.content) was pressed")
       // Fill me in!
        if (sender.content == ".") {
            updateResultLabel(sender.content)
            containsDecimal = true;
        } else if (sender.content == "0") {
            numberPressed(sender)
        }
    }
    
    // IMPORTANT: Do NOT change any of the code below.
    //            We will be using these buttons to run autograded tests.
    
    func makeButtons() {
        // MARK: Adds buttons
        let digits = (1..<10).map({
            return String($0)
        })
        let operators = ["/", "*", "-", "+", "="]
        let others = ["C", "+/-", "%"]
        let special = ["0", "."]
        
        let displayContainer = UIView()
        view.addUIElement(displayContainer, frame: CGRect(x: 0, y: 0, width: w, height: 160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }
        displayContainer.addUIElement(resultLabel, text: "0", frame: CGRect(x: 70, y: 70, width: w-70, height: 90)) {
            element in
            guard let label = element as? UILabel else { return }
            label.textColor = UIColor.white
            label.font = UIFont(name: label.font.fontName, size: 60)
            label.textAlignment = NSTextAlignment.right
        }
        
        let calcContainer = UIView()
        view.addUIElement(calcContainer, frame: CGRect(x: 0, y: 160, width: w, height: h-160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }

        let margin: CGFloat = 1.0
        let buttonWidth: CGFloat = w / 4.0
        let buttonHeight: CGFloat = 100.0
        
        // MARK: Top Row
        for (i, el) in others.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Second Row 3x3
        for (i, digit) in digits.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: digit), text: digit,
            frame: CGRect(x: x, y: y+101.0, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
            }
        }
        // MARK: Vertical Column of Operators
        for (i, el) in operators.enumerated() {
            let x = (CGFloat(3) + 1.0) * margin + (CGFloat(3) * buttonWidth)
            let y = (CGFloat(i) + 1.0) * margin + (CGFloat(i) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.backgroundColor = UIColor.orange
                button.setTitleColor(UIColor.white, for: .normal)
                button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Last Row for big 0 and .
        for (i, el) in special.enumerated() {
            let myWidth = buttonWidth * (CGFloat((i+1)%2) + 1.0) + margin * (CGFloat((i+1)%2))
            let x = (CGFloat(2*i) + 1.0) * margin + buttonWidth * (CGFloat(i*2))
            calcContainer.addUIElement(CustomButton(content: el), text: el,
            frame: CGRect(x: x, y: 405, width: myWidth, height: buttonHeight)) { element in
                guard let button = element as? UIButton else { return }
                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }

}


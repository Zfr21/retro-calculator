//
//  ViewController.swift
//  retro-calculator
//
//  Created by Zafer Celaloglu on 28.11.2015.
//  Copyright © 2015 Zafer Celaloglu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    @IBOutlet weak var outputLbl: UILabel!

    var btnSound: AVAudioPlayer!

    var runningNumber = ""
    var leftValStr = ""
    var rigthValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)

        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }

    func processOperation(op: Operation){
        playSound()

        if currentOperation != Operation.Empty {
            //run some math

            //A user selected operator, but then selected another operator without first entering a number
            if runningNumber != "" {

            rigthValStr = runningNumber
            runningNumber = ""

            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValStr)! * Double(rigthValStr)!)"
            }else if currentOperation == Operation.Divide {
                result = "\(Double(leftValStr)! / Double(rigthValStr)!)"
            }else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValStr)! - Double(rigthValStr)!)"
            }else if currentOperation == Operation.Add {
                result = "\(Double(leftValStr)! + Double(rigthValStr)!)"
            }

             leftValStr = result
             outputLbl.text = result
            }

             currentOperation = op

        }else {
            //this is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }

    }

    @IBAction func clear(sender: UIButton) {
        outputLbl.text = "0"
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValStr = ""
        rigthValStr = ""
    }
    func playSound(){
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }

}



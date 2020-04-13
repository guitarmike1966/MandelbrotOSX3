//
//  ViewController.swift
//  MandelbrotOSX3
//
//  Created by Michael O'Connell on 4/7/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Cocoa

let WIDTH = 1024
let HEIGHT = 768

let startWidth = 1.0 - -2.0
let startHeight = 1.25 - -1.25

let rate = 0.012

let startXA = -2.0
let startXB = 1.0
let startYA = -1.25
let startYB = 1.25


class ViewController: NSViewController {

    var xxa: Double = -2.0
    var xxb: Double = 1.0

    var xya: Double = -1.25
    var xyb: Double = 1.25


    @IBOutlet weak var MandelbrotImageView: CustomImageView!
    @IBOutlet weak var StartButton: NSButton!
    @IBOutlet weak var ImageCountLabel: NSTextField!

    var imageCounter: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func StartButtonClick(_ sender: Any) {

        for x in 0..<6 {

//            self.MandelbrotImageView.createImage()

//            let downloadURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
            self.imageCounter += 1
//            let fileName = String(format: "new-mandelbrot-%04d.png", self.imageCounter)
//            let destinationURL = downloadURL.appendingPathComponent(fileName)
//            let saveResult = self.MandelbrotImageView.image!.pngWrite(to: destinationURL)

            print("\nImage: \(imageCounter-1)")
            let oldValues = String(format: "xa: %1.17f  xb: %1.17f  ya: %1.17f  yb: %1.17f",
                                   MandelbrotImageView.xa,MandelbrotImageView.xb,MandelbrotImageView.ya,MandelbrotImageView.yb)
            print("  Old: \(oldValues)")

            // new calculation
            let newValues = String(format: "xa: %1.17f  xb: %1.17f  ya: %1.17f  yb: %1.17f",
                                   self.xxa,self.xxb,self.xya,self.xyb)
            print("  New: \(newValues)")


            let xWidth = self.MandelbrotImageView.xb - self.MandelbrotImageView.xa
            let xHeight = self.MandelbrotImageView.yb - self.MandelbrotImageView.ya

            let xShrink = xWidth * 0.00012
            let yShrink = xHeight * 0.00012

            self.MandelbrotImageView.xa += (xShrink * 0.5)
            self.MandelbrotImageView.xb -= (xShrink * 9.5)
            self.MandelbrotImageView.ya += (yShrink * 5)
            self.MandelbrotImageView.yb -= (yShrink * 5)

            // new calculation
            let xaMove = startWidth*pow((1 - rate), Double(imageCounter))
            
            let xbMove = startHeight*pow((1 + rate), Double(imageCounter))

            // calculate here the new xa,xb and ya,yb
            //
            let tempValue = String(format: "%1.17f                                %1.17f",xaMove,xbMove)
            print("     : \(tempValue)")

            DispatchQueue.main.async {
                self.ImageCountLabel.stringValue = String(format: "%04d", self.imageCounter)
            }

        }
    }
    
}


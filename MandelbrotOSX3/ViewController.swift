//
//  ViewController.swift
//  MandelbrotOSX3
//
//  Created by Michael O'Connell on 4/7/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Cocoa

let WIDTH = 800
let HEIGHT = 600

// let startWidth = 1.0 - -2.0
// let startHeight = 1.25 - -1.25

let Rate = 0.0012

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

        for x in 6..<12 {

            (xxa,xxb) = calc(a: startXA, b: startXB, iter: x, rate: Rate, portionA: 0.05, portionB: 0.95)
            (xya,xyb) = calc(a: startYA, b: startYB, iter: x, rate: Rate, portionA: 0.5, portionB: 0.5)

            self.MandelbrotImageView.xa = xxa
            self.MandelbrotImageView.xb = xxb
            self.MandelbrotImageView.ya = xya
            self.MandelbrotImageView.yb = xyb

            self.MandelbrotImageView.createImage()

            let downloadURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!

            self.imageCounter += 1
            let fileName = String(format: "new-mandelbrot-%04d.png", self.imageCounter)
            let destinationURL = downloadURL.appendingPathComponent(fileName)
            let saveResult = self.MandelbrotImageView.image!.pngWrite(to: destinationURL)

            DispatchQueue.main.async {
                self.ImageCountLabel.stringValue = String(format: "%05d", self.imageCounter)
            }

        }
    }
    
    
    private func calc(a: Double, b: Double, iter: Int, rate: Double, portionA: Double, portionB: Double) -> (Double,Double) {
        var aReturn: Double
        var bReturn: Double

        let Width = b - a
        let newWidth = Width * pow((1 - (rate)),Double(iter))

        let aChange = (Width - newWidth) * portionA
        let bChange = (Width - newWidth) * portionB
        aReturn = a + aChange
        bReturn = b - bChange

        return (aReturn,bReturn)
    }

    
}


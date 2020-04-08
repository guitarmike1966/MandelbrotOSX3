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

class ViewController: NSViewController {

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

        for x in 0..<1500 {
            self.MandelbrotImageView.createImage()

            let downloadURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
            self.imageCounter += 1
            let fileName = String(format: "new-mandelbrot-%04d.png", self.imageCounter)
            let destinationURL = downloadURL.appendingPathComponent(fileName)
            let saveResult = self.MandelbrotImageView.image!.pngWrite(to: destinationURL)

            let xWidth = self.MandelbrotImageView.xb - self.MandelbrotImageView.xa
            let xHeight = self.MandelbrotImageView.yb - self.MandelbrotImageView.ya

            let xShrink = xWidth * 0.00012
            let yShrink = xHeight * 0.00012

            self.MandelbrotImageView.xa += (xShrink * 0.5)
            self.MandelbrotImageView.xb -= (xShrink * 9.5)
            self.MandelbrotImageView.ya += (yShrink * 5)
            self.MandelbrotImageView.yb -= (yShrink * 5)
                
            DispatchQueue.main.async {
                self.ImageCountLabel.stringValue = String(format: "%04d", self.imageCounter)
            }

        }
    }
    
}


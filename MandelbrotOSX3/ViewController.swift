//
//  ViewController.swift
//  MandelbrotOSX3
//
//  Created by Michael O'Connell on 4/7/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Cocoa

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

        let downloadURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        imageCounter += 1
        let fileName = String(format: "new-mandelbrot-%04d.png", imageCounter)
        let destinationURL = downloadURL.appendingPathComponent(fileName)
        let saveResult = MandelbrotImageView.image!.pngWrite(to: destinationURL)
    }
    
}


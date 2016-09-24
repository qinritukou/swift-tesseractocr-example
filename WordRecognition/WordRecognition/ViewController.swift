//
//  ViewController.swift
//  WordRecognition
//
//  Created by 陳立紅 on 2016/09/19.
//  Copyright © 2016年 Orange Man. All rights reserved.
//

import UIKit
import TesseractOCR


class ViewController: UIViewController, G8TesseractDelegate {
    
    var imageView: UIImageView = UIImageView()
    var label: UILabel = UILabel()
    
    let image = UIImage(named: "OCR-Sample-Japanese")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.frame = CGRectMake(0, 0, self.view.frame.width, 300  )
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = image
        
        label.frame = CGRectMake(0, 300, self.view.frame.width, 200)
        label.lineBreakMode = NSLineBreakMode.ByCharWrapping
        label.numberOfLines = 0
        label.text = "Analyzing..."
        
        self.view.addSubview(imageView)
        self.view.addSubview(label)
        
        analyze()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func analyze() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            let tess = G8Tesseract(language: "jpn")
            
            if let tesseract = tess {
                tesseract.delegate = self
                tesseract.image = self.image
                tesseract.recognize()
                
                let text = tesseract.recognizedText
                print(text)
                self.label.text = text
            } else {
                print("load data failed")
            }
        })
    }

    func shouldCancelImageRecognitionForTesseract(tesseract: G8Tesseract!) -> Bool {
        return false; // return true if you need to interrupt tesseract before it finishes
    }
    
}


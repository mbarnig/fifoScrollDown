//
//  ViewController.swift
//  fifoScrollDown
//
//  Created by Marco Barnig on 10/11/2016.
//  Copyright © 2016 Marco Barnig. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    let maxSizeMessageBuffer = MaxSizeMessageBuffer()
    
    @IBOutlet var myTextView: NSTextView!  
    
    @IBAction func test(_ sender: Any) {
        maxSizeMessageBuffer.initialize(Size: 9) 
        // add initial messages to the MessageBuffer
        for i in 1...9 {
            let testString = String(repeating:String(i), count:i)
            _ = maxSizeMessageBuffer.addNewMessage(message: testString)
        }
        // display MessageBuffer
        let myText = maxSizeMessageBuffer.readAllMessages()  
        myTextView.string = myText       
        myTextView.scrollToEndOfDocument(self) 
    }  // end func   
    
    @IBOutlet weak var myLabel: NSTextField! 
    
    @IBAction func enter(_ sender: Any) {  
        let newMessage = myLabel.stringValue 
        _ = maxSizeMessageBuffer.addNewMessage(message: newMessage)  
        let myText = maxSizeMessageBuffer.readAllMessages()  
        myTextView.string = myText       
        myTextView.scrollToEndOfDocument(self)  
    }  // end func    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
       // self.myTextView.layoutManager?.allowsNonContiguousLayout = false
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


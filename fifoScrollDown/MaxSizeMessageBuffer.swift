//
//  MaxSizeMessageBuffer.swift
//  fifoScrollDown
//
//  Created by Marco Barnig on 14/11/2016.
//  Copyright © 2016 Marco Barnig. All rights reserved.
//

import Cocoa

class MaxSizeMessageBuffer: NSObject {
    
    var size = 10         // default size
    var outputText = ""   // messageBuffer
    var counter = 0       // current number of messages in messageBuffer
    
    var ringBuffer = RingBuffer<Int>(count: 1)  
    
    func initialize(Size: Int) {
        size = Size
        outputText = ""
        counter = 0
        ringBuffer = RingBuffer<Int>(count:Size)
    }  // end func
    
    func readAllMessages() -> String {
        return outputText
    }  // end func
    
    func addNewMessage(message: String) -> Bool {
        counter += 1  
        let addText = message + "\n"
        outputText += addText
        let charNumber = addText.characters.count 
        // add the length of the new message to the ringBuffer
        _ = ringBuffer.write(element:charNumber) 
        if counter > size {
            // delete the oldest message from the messageBuffer
            let rangeLength = ringBuffer.read()!
            let start = outputText.index(outputText.startIndex, offsetBy: 0)
            let end = outputText.index(outputText.startIndex, offsetBy: rangeLength)
            let range = start..<end  
            outputText.removeSubrange(range)  
        }  // end if
        return true
    }  // end func
    
}  // end class

public struct RingBuffer<T> {
    private var array: [T?]
    private var readIndex = 0
    private var writeIndex = 0
    
    public init(count: Int) {
        array = [T?](repeating: nil, count: count)
    }
    
    /* Returns false if out of space. */
    public mutating func write(element: T) -> Bool {
        if !isFull {
            array[writeIndex % array.count] = element
            writeIndex += 1
            return true
        } else {
            return false
        }
    }
    
    /* Returns nil if the buffer is empty. */
    public mutating func read() -> T? {
        if !isEmpty {
            let element = array[readIndex % array.count]
            readIndex += 1
            return element
        } else {
            return nil
        }
    }
    
    private var availableSpaceForReading: Int {
        return writeIndex - readIndex
    }
    
    public var isEmpty: Bool {
        return availableSpaceForReading == 0
    }
    
    private var availableSpaceForWriting: Int {
        return array.count - availableSpaceForReading
    }
    
    public var isFull: Bool {
        return availableSpaceForWriting == 0
    }
}  // end structure    


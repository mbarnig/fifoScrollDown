//
//  loremIpsum.swift
//  fifoScrollDown
//
//  Created by Marco Barnig on 10/11/2016.
//  Copyright © 2016 Marco Barnig. All rights reserved.
//

import Cocoa

var outputText = ""

class Requester: NSObject, URLSessionDelegate, URLSessionDataDelegate {
       
    var response: URLResponse?
    var session: URLSession?
    let opQueue = OperationQueue()
    
    func operation() {
        print("download function started")        
        let config = URLSessionConfiguration.default      // Session configuration
        self.session = URLSession(configuration: config, delegate: self, delegateQueue: self.opQueue)  // load configuration into session
        let url = URL(string: "http://loripsum.net/api/100/short/plaintext")          
        let request = URLRequest(url: url!)
        if let task = session?.dataTask(with: request) {
            // task are not started by default
            task.resume()
        }
    }  // end func
    
    // The delegate is informed that the session has been invalidated by calling finishTasksAndInvalidate() or
    // invalidateAndCancel(). 
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        if let err = error {
            print("Error: \(err.localizedDescription)")
        } else {
            print("The session has been terminated.")
        }
    }  // end func
    
    // The delegate is informed that the data task has received the initial reply (header) from the server.
    // This function is optional
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print("did receive response")
        self.response = response
        print(self.response!)
        completionHandler(URLSession.ResponseDisposition.allow)
    }  // end func
    
    // The delegate is informed that the data task has received some of the expected data. 
    // Each call only provides data received since the preceding function call.
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("did receive data")
        if let responseText = String(data: data, encoding: .utf8) {
            outputText += responseText
        }
    }  // end func
    
    // The delegate is informed that the data transfer is finished. Server errors are not reported, only client errors.
    // Server errors are reported in the HTTP response. The transfer was successful if error == nil.
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        // the task finished
        if let err = error {
            print("Error: \(err.localizedDescription)")
        } else {
            print("The download was successful.")
            self.session?.finishTasksAndInvalidate()
        }
    }  // end func    
    
}  // end class


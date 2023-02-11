//
//  LuloDownload.swift
//  
//
//  Created by Juan Hurtado on 1/02/23.
//

import Foundation


public class LuloDownload {
    /// The actual task.
    let task: URLSessionDownloadTask
    
    init(task: URLSessionDownloadTask) {
        self.task = task
    }
    
    /// Starts the download.
    func start() {
        task.resume()
    }
    
    /// Cancels the download.
    public func cancel() {
        task.cancel()
    }
}

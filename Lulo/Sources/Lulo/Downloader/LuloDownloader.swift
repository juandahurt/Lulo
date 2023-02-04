//
//  LuloDownloader.swift
//  
//
//  Created by Juan Hurtado on 1/02/23.
//

import Foundation

/// The image downloader.
class LuloDownloader: NSObject {
    /// Downloader's delegate.
    var delegate: LuloDownloaderDelegate?
    
    init(delegate: LuloDownloaderDelegate? = nil) {
        self.delegate = delegate
    }
    
    /// Initializes the download.
    /// - Parameter url: The image URL
    /// - Returns: The instance of the  download.
    func initDownload(with url: URL) -> LuloDownload {
        var request = URLRequest(url: url)
        request.timeoutInterval = 15
        let session = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: nil)
        let task = session.downloadTask(with: request)
        return .init(task: task)
    }
}


extension LuloDownloader: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        delegate?.didFinish()
        if let data = try? Data(contentsOf: location) {
            delegate?.downloader(self, didFinishDownloadingData: data)
        }
    }
    
    func urlSession(_ session: URLSession, didCreateTask task: URLSessionTask) {
        delegate?.willStartDownloading(self)
    }
}

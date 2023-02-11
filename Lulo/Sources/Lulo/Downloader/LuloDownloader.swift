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

// MARK: - URLSessionDownloadDelegate
extension LuloDownloader: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let data = try? Data(contentsOf: location) {
            delegate?.downloader(self, didFinishDownloadingData: data)
        } else {
            // TODO: check if its possible that the bytes can't be "decoded" from the downloaded file
            // TODO: call didFinishWithError (?)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        // There's something funny about the `NSURLSessionDownloadDelegate`: if the download has
        // complete, the `didFinishDownloadingTo` and `didCompleteWithError` methods will be called both xd.
        // So, that's why I call the `LuloDownloaderDelegate` `didFinishWithError` method in here...
        if let error {
            delegate?.downloader(self, didFinishWithError: error)
        }
    }
    
    func urlSession(_ session: URLSession, didCreateTask task: URLSessionTask) {
        delegate?.willStartDownloading(self)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        delegate?.downloader(self, didDownloadBytes: bytesWritten, totalBytesDownloaded: totalBytesWritten, totalBytesExpectedToDownload: totalBytesExpectedToWrite)
    }
}

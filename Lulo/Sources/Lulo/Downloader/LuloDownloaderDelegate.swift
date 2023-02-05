//
//  LuloDownloaderDelegate.swift
//  
//
//  Created by Juan Hurtado on 4/02/23.
//

import Foundation
import UIKit

/// The methods that the downloader uses to notify its status.
protocol LuloDownloaderDelegate: AnyObject {
    /// Tells te delegate the download finished with an error.
    /// - Parameters:
    ///   - downloader: The downloader object that is indicating the download is about start.
    ///   - error: The error that occured.
    func downloader(_ downloader: LuloDownloader, didFinishWithError error: Error)
    
    /// Tells the delegate that the download is about to start.
    /// - Parameter downloader: The downloader object that is indicating the download is about start.
    func willStartDownloading(_ downloader: LuloDownloader)
    
    /// Tells the delegate the downloader has downloaded certain data.
    /// - Parameters:
    ///   - downloader: The downloader object that is calling this method.
    ///   - data: The downloaded data.
    func downloader(_ downloader: LuloDownloader, didFinishDownloadingData data: Data)
}


class LuloDefaultDownloaderDelegate: LuloDownloaderDelegate {
    /// Current download context.
    let context: LuloDownloadContext
    
    init(context: LuloDownloadContext) {
        self.context = context
    }
    
    func downloader(_ downloader: LuloDownloader, didFinishWithError error: Error) {
        context.onComplete?(error)
    }
    
    func downloader(_ downloader: LuloDownloader, didFinishDownloadingData data: Data) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if let placeholder = self.context.placeholder, placeholder == .indicator {
                self.context.container?.subviews.forEach {
                    if $0 is UIActivityIndicatorView {
                        $0.removeFromSuperview()
                    }
                }
            }
            if let image = UIImage(data: data) {
                self.context.container?.image = image
            }
        }
    }
    
    func willStartDownloading(_ downloader: LuloDownloader) {
        guard let placeholder = context.placeholder else { return }
        guard let container = context.container else { return }
        switch placeholder {
        case .image(let image):
            container.image = image
        case .indicator:
            container.image = nil
            // TODO: resize indicator based on image view size
            let indicator = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 50, height: 50))
            indicator.startAnimating()
            container.addSubview(indicator)
            indicator.center = container.center
        }
    }
}

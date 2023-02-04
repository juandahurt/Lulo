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
    /// Tells the delegate that the download has finished.
    func didFinish()
    /// Tells the delegate that the download
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
    
    func didFinish() {
        context.onComplete?()
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
            let indicator = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 50, height: 50))
            indicator.startAnimating()
            container.addSubview(indicator)
            indicator.center = container.center
        }
    }
}

//
//  LuloDownloadbleImage.swift
//  
//
//  Created by Juan Hurtado on 1/02/23.
//

import Foundation
import UIKit

public enum LuloImagePlaceholder: Equatable {
    case image(UIImage)
    case indicator
}

struct LuloDownloadContext {
    var onComplete: ((Error?) -> Void)?
    var container: UIImageView?
    var placeholder: LuloImagePlaceholder?
}

/// A builder class that allows you to download an image from the web.
public class LuloDownloadbleImage {
    let url: URL
    let downloader = LuloDownloader()
    var context = LuloDownloadContext()
    
    init(url: URL) {
        self.url = url
    }
    
    /// Sets the  on-complete handler.
    /// - Parameter handler: Function that will be called when the download finishes.
    /// - Returns: The current downloadble image instace.
    public func onComplete(_ handler: @escaping (Error?) -> Void) -> LuloDownloadbleImage {
        context.onComplete = handler
        return self
    }
    
    /// Call this function to indiciate where the image has to be placed in.
    /// - Parameter imageView: The image view where the image will be palced in when downloaded
    /// - Returns: The current downloadble image instace.
    public func set(to imageView: UIImageView) -> LuloDownloadbleImage {
        context.container = imageView
        return self
    }
    
    /// Sets a placeholder.
    ///
    /// It will be shown while the download is in progress or an error occures.
    ///
    /// Be aware of calling `set(to: imageView: UIImageView)` also.
    /// - Parameter placeholder: The placeholder you want to show.
    /// - Returns: The current downloadble image instace.
    public func withPlaceholder(_ placeholder: LuloImagePlaceholder) -> LuloDownloadbleImage {
        context.placeholder = placeholder
        return self
    }
    
    /// Stars the downlad.
    /// - Returns: The download instance.
    @discardableResult
    public func download() -> LuloDownload {
        downloader.delegate = LuloDefaultDownloaderDelegate(context: context)
        let download = downloader.initDownload(with: url)
        download.start()
        return download
    }
}

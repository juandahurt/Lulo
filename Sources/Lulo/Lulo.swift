import Foundation
import UIKit


/// Main entry point
public struct Lulo {
    /// Creates a downloable image.
    /// - Parameter url: The URL where the image will be downloaded from.
    /// - Returns: An instance of a new downloadble image.
    public static func image(from url: URL) -> LuloDownloadbleImage {
        LuloDownloadbleImage(url: url)
    }
}

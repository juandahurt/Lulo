//
//  ProgresExampleViewController.swift
//  LuloDemo
//
//  Created by Juan Hurtado on 11/02/23.
//

import Lulo
import UIKit

class ProgresExampleViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var downloableImage: LuloDownloadbleImage?
    
    init() {
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDownload()
        setupSubviews()
    }
    
    private func setupSubviews() {
        progressView.setProgress(0, animated: false)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.placeholderText.cgColor
    }
    
    private func setupDownload() {
        let url = URL(string: "https://payan-places.s3.us-east-2.amazonaws.com/003/001.jpg")!
        downloableImage = Lulo.image(from: url)
            .onProgress { [weak self] percentage in
                guard let self else { return }
                self.progressView.setProgress(Float(percentage), animated: true)
            }
            .set(to: imageView)
    }
    
    @IBAction func onDownloadTapped(_ sender: UIButton) {
        progressView.setProgress(0, animated: false)
        downloableImage?.download()
    }
}

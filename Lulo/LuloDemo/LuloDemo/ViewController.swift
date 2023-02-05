//
//  ViewController.swift
//  LuloDemo
//
//  Created by Juan Hurtado on 28/01/23.
//

import UIKit
import Lulo

class ViewController: UIViewController {
    var downloadbleImage: LuloDownloadbleImage?
    var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupDownloadbleImage()
    }
    
    private func setupDownloadbleImage() {
        guard let imageView else { return }
        let url = URL(string: "https://payan-places.s3.us-east-2.amazonaws.com/003/001.jpg")!
        downloadbleImage = Lulo.image(from: url)
            .set(to: imageView)
            .withPlaceholder(.indicator)
    }
    
    func setupSubviews() {
        imageView = UIImageView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        imageView?.layer.borderWidth = 1
        imageView?.layer.borderColor = UIColor.placeholderText.cgColor
        
        let button = UIButton(frame: .init(x: 0, y: 0, width: 80, height: 30))
        button.setTitle("Download", for: .normal)
        button.backgroundColor = .link
        button.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        
        let stackView = UIStackView(frame: .init(x: 0, y: 0, width: 100, height: 150))
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.addArrangedSubview(imageView!)
        stackView.addArrangedSubview(button)
        stackView.center = view.center
        
        view.addSubview(stackView)
    }
    
    @objc
    func onTap(_ sender: UIButton) {
        downloadbleImage?.download()
    }
}

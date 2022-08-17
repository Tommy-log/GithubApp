//
//  LoaderView.swift
//  RxSwiftMVVM
//
//  Created by User on 17.08.2022.
//

import UIKit

public final class LoaderView: UIView {
    let imageView = UIImageView(image: UIImage(named: "premium-icon-refresh"))
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func showLoader(_ show: Bool) {
        isHidden = !show
        show ?
        circleAnimate() :
        stopAnimation()
    }
    
    private func setup() {
        [imageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constatns.imageViewSize.width),
            imageView.heightAnchor.constraint(equalToConstant: Constatns.imageViewSize.height)
        ])
    }
    
    private func circleAnimate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = -Double.pi * 3
        rotation.duration = Constatns.animationDuration
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        imageView.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    private func stopAnimation() {
        imageView.layer.removeAnimation(forKey: "rotationAnimation")
    }
}

private enum Constatns {
    static let imageViewSize = CGSize(width: 40, height: 40)
    static let animationDuration: TimeInterval = 1
}



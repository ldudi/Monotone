//
//  CapsuleButton.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/11/29.
//

import UIKit

class CapsuleButton: BaseButton {
    
    // MARK: - Enums
    enum BackgroundStyle{
        case normal
        case blur
    }
    
    // MARK: - Public
    public var backgroundStyle: BackgroundStyle = .normal{
        didSet{
            self.updateBackgroundStyle()
        }
    }
    
    // MARK: - Private
    private var blurBackgroundView: UIVisualEffectView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    // MARK: - Life Cycle
    override func buildSubviews(){
        super.buildSubviews()
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        self.contentEdgeInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 25.0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: -10.0)
        
        // BlurBackgroundView.
        let blurEffect = UIBlurEffect(style: .light)
        self.blurBackgroundView = UIVisualEffectView(effect: blurEffect)
        self.blurBackgroundView.isUserInteractionEnabled = false
    }
    
    override func buildLogic(){
        super.buildLogic()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.size.height / 2.0
        self.layer.masksToBounds = true
    }
    
    private func updateBackgroundStyle(){
        switch self.backgroundStyle {
        case .normal:
            
            self.blurBackgroundView.removeFromSuperview()
            self.backgroundColor = UIColor.black
            break
        case .blur:
            
            self.insertSubview(self.blurBackgroundView, belowSubview: self.imageView!)
            self.blurBackgroundView.snp.makeConstraints { (make) in
                make.left.top.right.bottom.equalTo(self)
            }
            self.backgroundColor = UIColor.clear
            break
        }
    }
}

//
//  ControlView.swift
//  Pip
//
//  Created by 李永杰 on 2021/12/1.
//

import UIKit
import ZFPlayer
import SnapKit

@objc protocol NPControlViewDelegate {
    func didClickPip()
}

class NPControlView: UIView, ZFPlayerMediaControl {
    var player: ZFPlayerController?
    
    weak var delegate: NPControlViewDelegate?
    
    
    @objc func didClickPip() {
        delegate?.didClickPip()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(pipButton)
        
        pipButton.snp.remakeConstraints { make in
            make.right.equalTo(-20)
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var pipButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "video_pip"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(didClickPip), for: .touchUpInside)
        return button
    }()
}

//
//  ViewController.swift
//  Pip
//
//  Created by 李永杰 on 2021/12/1.
//

import UIKit
import ZFPlayer
import AVKit
import SnapKit

class ViewController: UIViewController {

    var player = ZFPlayerController()
    
    var pictureInPictureController : AVPictureInPictureController?

    var isForeground = true // 在前台关闭pip继续播放,根据业务取舍
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configPlayer()
        beginPlay()
        
        configPip()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveEnterForeground), name: NSNotification.Name(rawValue: UIApplication.willEnterForegroundNotification.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveEnterBackground), name: NSNotification.Name(rawValue: UIApplication.didEnterBackgroundNotification.rawValue), object: nil)

    }
    
    func beginPlay() {
        let assetUrl = URL(string: "https://www.w3school.com.cn/example/html5/mov_bbb.mp4")!
        self.player.currentPlayerManager.assetURL = assetUrl
    }
     
    func configPlayer() {
        
        // 播放器相关
        self.player = ZFPlayerController.player(withPlayerManager: commonManager, containerView: containerView)
        self.player.currentPlayerManager.scalingMode = .aspectFit
        self.player.controlView = self.controlView
        self.player.controlView.window?.backgroundColor = .black
        
        self.player.pauseWhenAppResignActive = false
        self.player.shouldAutoPlay = false
        self.player.currentPlayerManager.view.backgroundColor = .black
        
        self.player.playerDidToEnd = { [weak self] asset in
            self?.player.currentPlayerManager.replay()
        }
    }
     
    private func configUI() {
         
        self.view.addSubview(containerView)
        let width: CGFloat = self.view.frame.width // 设置全屏，不然不会自动触发pip
        let height: CGFloat = width/16*9
        containerView.snp.remakeConstraints { make in
            make.top.equalTo(100)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    deinit {
        self.player.stop()
    }
    
    lazy var containerView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ""))
        imageView.backgroundColor = .black
        return imageView
    }()
     
    lazy var controlView: NPControlView = {
        let view = NPControlView()
        view.delegate = self
        return view
    }()
    
    let commonManager = ZFAVPlayerManager()
    
}


//
//  ViewController+Pip.swift
//  Pip
//
//  Created by 李永杰 on 2021/12/1.
//
 
import AVKit

extension ViewController : AVPictureInPictureControllerDelegate {
    
    public func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("将要开始PictureInPicture的代理方法")
    }

    public func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("已经开始PictureInPicture的代理方法")
    }

    public func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: Error) {
        print("启动PictureInPicture失败的代理方法")
    }
    
    public func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("将要停止PictureInPicture的代理方法")
    }
    
    public func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("已经停止PictureInPicture的代理方法")
        
        commonManager.pause()
        // 在前台关闭pip继续播放
        if commonManager.playState == .playStatePaused && isForeground {
            commonManager.play()
        }
    }

    public func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        //此方法执行在pictureInPictureControllerWillStopPictureInPicture代理方法之前。 但是点击“X”移除画中画时，不执行此方法。
        print("PictureInPicture停止之前恢复用户界面")
        completionHandler(true)
    }
}

extension ViewController {
    func configPip() {
        if AVPictureInPictureController.isPictureInPictureSupported() {
            let playerLayer = commonManager.avPlayerLayer!
            pictureInPictureController = AVPictureInPictureController(playerLayer: playerLayer)
            pictureInPictureController?.delegate = self
        } else {
            print("当前设备不支持PiP")
        }
    }
}


extension ViewController: NPControlViewDelegate {
    
    // 手动触发
    func didClickPip() {
        if !AVPictureInPictureController.isPictureInPictureSupported() {
            return
        }
        if self.pictureInPictureController!.isPictureInPictureActive {
            self.pictureInPictureController!.stopPictureInPicture()
        } else {
            self.pictureInPictureController!.startPictureInPicture()
        }
    }
}

//
//  ViewController+Noti.swift
//  Pip
//
//  Created by 李永杰 on 2021/12/1.
//

import Foundation

extension ViewController {
    @objc func didReceiveEnterForeground() {
        
        isForeground = true
        if pictureInPictureController != nil {
            if pictureInPictureController!.isPictureInPictureActive {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                    self!.pictureInPictureController!.stopPictureInPicture()
                }
            }
        }
        
    }
    
    @objc func didReceiveEnterBackground() {
        isForeground = false
    }
}

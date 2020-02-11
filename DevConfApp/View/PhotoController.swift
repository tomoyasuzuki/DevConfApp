//
//  PhotoController.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/11.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Photos
import UIKit
import RxSwift

protocol PhotoManager {
    
}

class PhotoController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let cancelObserver: PublishSubject<Void> = PublishSubject()
    let imagePickerObserver: PublishSubject<UIImage?> = PublishSubject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.sourceType = .photoLibrary
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return super.preferredInterfaceOrientationForPresentation
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        imagePickerObserver.onNext(image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        cancelObserver.onNext(())
    }
}

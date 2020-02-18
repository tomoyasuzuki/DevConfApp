//
//  ProfileSettingViewModel.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/15.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import RxSwift
import RxCocoa

struct ProfileSettingInput {
    let profileImage: Driver<UIImage?>
    let nickName: Driver<String>
    let introText: Driver<String>
    let nextButtonTapped: Driver<Void>
}

struct ProfileSettingOutput {
    let settingUpdate: Driver<ViewAction>
}

protocol ProfileSettingViewModelInterface {
    func bind(input: ProfileSettingInput) -> ProfileSettingOutput
}

final class ProfileSettingViewModel: ProfileSettingViewModelInterface {
    
    var usecase: UserUseCase
    
    var uid: String?
    
    init(usecase: UserUseCase) {
        self.usecase = usecase
    }
    
    func bind(input: ProfileSettingInput) -> ProfileSettingOutput {
        let update = Observable
            .zip(input.profileImage.asObservable(),
                 input.nickName.asObservable(),
                 input.introText.asObservable(),
                 input.nextButtonTapped.asObservable())
            .flatMap { [weak self] image, nickName, introText, _  -> Observable<Error?> in
                guard let sSelf = self, let uid = sSelf.uid else {
                    return Observable.of(CommonError.unknownError)
                }
                
                return sSelf.usecase
                    .updateUserProfileImage(id: uid, image: image!)
                    .flatMap { err ->  Observable<Error?>in
                        if let err = err {
                            return Observable.of(err)
                        } else {
                            let path = UserDefaults.standard.string(forKey: "profileImageUrl")
                            
                            return sSelf.usecase.updateUserInfo(id: uid, nickName: nickName, profileImageUrl: path, introText: introText)
                        }
                    }
            }
            .map { err -> ViewAction in
                if let err = err as? ProfileError {
                    switch err {
                    case .updateImageFail:
                        let errMessage = "画像のアップロードに失敗しました。"
                        
                        return ProfileSettingViewAction.showImageUploadError(errMessage)
                    case .updateInfoFail:
                        let errMessage = "ユーザー情報の更新に失敗しました。"
                        
                        return ProfileSettingViewAction.showUserInfoUploadError(errMessage)
                    }
                } else if let err = err as? CommonError {
                    switch err {
                    case .networkingError:
                        let errMessage = "通信状態が不安定です。電波の良い場所でもう一度お試しください。"
                        
                        return ProfileSettingViewAction.showImageUploadError(errMessage)
                    case .unknownError:
                        let errMessage = "予期せぬエラーが発生しました"
                        
                        return ProfileSettingViewAction.showImageUploadError(errMessage)
                    }
                } else {
                    return ProfileSettingViewAction.navigateToHome
                }
        }.asDriverWithEmpty()
        
        return ProfileSettingOutput(settingUpdate: update)

    }
}

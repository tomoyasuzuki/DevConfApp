//
//  Presenter.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/12.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

protocol Presenter {
    associatedtype Input
    associatedtype Output
    func bind(input: Input) -> Output
}

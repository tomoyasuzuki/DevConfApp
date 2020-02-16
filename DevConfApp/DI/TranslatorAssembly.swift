//
//  Translator.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/17.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Swinject

class TranslatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TranslatorInterface.self) { _ in
            return Translator()
        }
    }
}

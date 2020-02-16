//
//  DIContainer.swift
//  DevConfApp
//
//  Created by 鈴木友也 on 2020/02/17.
//  Copyright © 2020 tomoya.suzuki. All rights reserved.
//

import Swinject

var resolver: Resolver {
    return assembler.resolver
}

fileprivate var assembler = Assembler([ViewControllerAssembly(),
                                      ViewModelAssembly(),
                                      UseCaseAssembly(),
                                      RepositoryAssembly(),
                                      DataStoreAssembly(),
                                      TranslatorAssembly()])

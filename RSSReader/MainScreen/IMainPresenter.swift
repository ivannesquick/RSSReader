//
//  IMainPresenter.swift
//  RSSReader
//
//  Created by Neskin Ivan on 09.12.2020.
//  Copyright © 2020 Neskin Ivan. All rights reserved.
//

import Foundation

protocol IMainPresenter: class {
    func getData()
    func getItems() -> [Item]
    func dataCount() -> Int
    func monoEffect()
    func chromeEffect()
}

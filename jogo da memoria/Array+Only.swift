//
//  Array+Only.swift
//  jogo da memoria
//
//  Created by Luan Araujo on 28/03/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first: nil
    }
}

//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Кирилл Копытин on 20.12.2021.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}

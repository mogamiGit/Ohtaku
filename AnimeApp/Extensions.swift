//
//  Extensions.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 23/4/23.
//

import Foundation

extension String {
    func toArray() -> [String] {
        return self.components(separatedBy: ",")
    }
}

//
//  SearchResultsModel.swift
//  uran
//
//  Created by Tarasenko Jurik on 08.02.2020.
//  Copyright © 2020 Next Level. All rights reserved.
//

import Foundation

struct SearchResultsModel: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: [ImageSize.RawValue: String]
    
}

enum ImageSize: String {
    case raw, full, regular, small, thumb
}



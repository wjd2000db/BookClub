//
//  BookData.swift
//  BookClub
//
//  Created by Yujin on 11/23/24.
//

import Foundation

struct Results: Decodable {
    let totalItems: Int
    let items: [Book]?
}

struct Book: Decodable, Identifiable {
    let id: String
    let kind: String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    let title: String
    let authors: [String]?
    let description: String?
    let publishedDate: String?
    let previewLink: String?
}


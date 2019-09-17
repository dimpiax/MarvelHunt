//
//  ComicsData.swift
//  MarvelHunt
//
//  Created by Dmytro Pylypenko on 9/16/19.
//  Copyright © 2019 FeeTime. All rights reserved.
//

import Foundation

struct ComicsData {
  let id: Int
  let title: String
  let variantDescription: String
  let desc: String
  let thumbnail: URL
  let issue: URL?
}

extension ComicsData: Decodable {
  private enum Key: String, CodingKey {
    case
      id,
      title,
      variantDescription,
      description,
      thumbnail,
      urls
  }
  
  private struct Thumbnail: Decodable {
    let path: String
    let `extension`: String
    
    var url: URL? {
      return URL(string: "\(path).\(self.extension)")
    }
  }
  
  private struct Issues: Decodable {
    let url: URL
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Key.self)
    
    id = try container.decode(Int.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)
    variantDescription = try container.decode(String.self, forKey: .variantDescription)
    desc = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail).url!
    issue = try container.decodeIfPresent([Issues].self, forKey: .urls)?.first?.url
  }
}

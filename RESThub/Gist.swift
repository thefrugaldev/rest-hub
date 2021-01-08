//
//  Gist.swift
//  RESThub
//
//  Created by Clayton Orman on 1/4/21.
//

import Foundation

struct Gist: Encodable {
    var id: String?
    var isPublic: Bool
    var description: String
    var files: [String: File]
    
    /* Allows for key mapping for names that don't match */
    /* Fallthrough for keys that do match */
    enum CodingKeys: String, CodingKey {
        case id, description, files, isPublic = "public"
    }
    
    /* Allows for implemnting custom encoding logic */
    func encode(to encoder: Encoder) throws {
        /* Container to store properties and values while they're being encoded */
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(isPublic, forKey: .isPublic)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(files, forKey: .files)
    }
}

extension Gist: Decodable {
    /* Tells the Codable protocol that we want to handle our own custom decoding */
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.isPublic = try container.decode(Bool.self, forKey: .isPublic)
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? "Description is nil"
        self.files = try container.decode([String: File].self, forKey: .files)
    }
}

struct File: Codable {
    var content: String?
}

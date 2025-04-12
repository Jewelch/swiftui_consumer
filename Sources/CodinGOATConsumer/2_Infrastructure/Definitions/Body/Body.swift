//
//  Body.swift
//  SwiftUI_Consumer
//
//  Created by Jewel CHERIAA on 02/06/2023.
//

import Foundation

public struct Body {
    public init(encoding: Body.DataEncoding, params: Params? = nil, files: [FileModel]? = nil) {
        self.encoding = encoding
        self.params = params
        self.files = files
    }

    public var encoding: DataEncoding
    public var params: Params?
    public var files: [FileModel]?

    public enum DataEncoding { case UTF8, JSON, MULTIPART }
}

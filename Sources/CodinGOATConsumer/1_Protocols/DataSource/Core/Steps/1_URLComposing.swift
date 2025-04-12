//
//  URLComposing.swift
//
//  Created by Jewel CHERIAA on 02/06/2023.
//

import Foundation

public struct URLComposer {
    public let host: String
    public let path: String
    public var queryItems: String?

    public init(host: String? = nil, path: String, queryItems: Params? = nil) {
        self.host = host ?? DataSourceConfigurator.baseApiHost
        assert(!self.host.isEmpty, """
        --------------------------------------------------------------------------------------------------
        \nYou've probably forgot to provide the DataSourceConfiguration's baseApiHost
        --------------------------------------------------------------------------------------------------
        """)
        self.path = path
        queryItems?.ifUniqueMerge(in: &DataSourceConfigurator.autoInjectableQueryItems)

        if !DataSourceConfigurator.autoInjectableQueryItems.isEmpty {
            self.queryItems = "?".optionallyAppending(DataSourceConfigurator.autoInjectableQueryItems.formattedAsUrlQueryItems())
        }
    }

    public var endpoint: String {
        return host.appending(path).optionallyAppending(queryItems)
    }
}

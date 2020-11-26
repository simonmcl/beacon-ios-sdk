//
//  Response.swift
//  BeaconSDK
//
//  Created by Julia Samol on 13.11.20.
//  Copyright © 2020 Papers AG. All rights reserved.
//

import Foundation

extension Beacon {
    
    public enum Response {
        case permission(Permission)
        case operation(Operation)
        case signPayload(SignPayload)
        case broadcast(Broadcast)
        case error(Error)
        
        // MARK: Attributes
        
        var identifier: String {
            switch self {
            case let .permission(content):
                return content.id
            case let .operation(content):
                return content.id
            case let .signPayload(content):
                return content.id
            case let .broadcast(content):
                return content.id
            case let .error(content):
                return content.id
            }
        }
    }
}

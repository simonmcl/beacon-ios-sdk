//
//  SignPayloadV2TezosResponse.swift
//
//
//  Created by Julia Samol on 13.11.20.
//  Copyright © 2020 Papers AG. All rights reserved.
//

import Foundation
import BeaconCore
    
public struct SignPayloadV2TezosResponse: V2BeaconMessageProtocol {
    public let type: String
    public let version: String
    public let id: String
    public let senderID: String
    public let signingType: Tezos.SigningType
    public let signature: String
    
    init(version: String, id: String, senderID: String, signingType: Tezos.SigningType, signature: String) {
        type = SignPayloadV2TezosResponse.type
        self.version = version
        self.id = id
        self.signingType = signingType
        self.senderID = senderID
        self.signature = signature
    }
    
    // MARK: BeaconMessage Compatibility
    
    public init(from beaconMessage: BeaconMessage<Tezos>, senderID: String) throws {
        switch beaconMessage {
        case let .response(response):
            switch response {
            case let .blockchain(blockchain):
                switch blockchain {
                case let .signPayload(content):
                    self.init(from: content, senderID: senderID)
                default:
                    throw Beacon.Error.unknownBeaconMessage
                }
            default:
                throw Beacon.Error.unknownBeaconMessage
            }
        default:
            throw Beacon.Error.unknownBeaconMessage
        }
    }
    
    public init(from beaconMessage: SignPayloadTezosResponse, senderID: String) {
        self.init(
            version: beaconMessage.version,
            id: beaconMessage.id,
            senderID: senderID,
            signingType: beaconMessage.signingType,
            signature: beaconMessage.signature
        )
    }
    
    public func toBeaconMessage(
        with origin: Beacon.Origin,
        completion: @escaping (Result<BeaconMessage<Tezos>, Swift.Error>) -> ()
    ) {
        completion(.success(.response(
            .blockchain(
                .signPayload(
                    .init(
                        id: id,
                        version: version,
                        requestOrigin: origin,
                        signingType: .raw,
                        signature: signature
                    )
                )
            )
        )))
    }
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        case type
        case version
        case id
        case senderID = "senderId"
        case signingType
        case signature
    }
}

extension SignPayloadV2TezosResponse {
    public static let type = "sign_payload_response"
}

//
//  DarrellLog.swift
//  PcapngPrint
//
//  Created by Darrell Root on 2/6/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import Foundation
import Logging

// initially this is a copy of StreamLogHandler built into
// the Apple Logging API.  My own copy will let me modify

public struct DarrellLogHandler: LogHandler {

    private let label: String

    public var logLevel: Logger.Level = .error // set to .info or .debug for troubleshooting

    private var prettyMetadata: String?
    public var metadata: Logger.Metadata = [:]

    public subscript(metadataKey metadataKey: String) -> Logger.Metadata.Value? {
        get {
            return self.metadata[metadataKey]
        }
        set {
            self.metadata[metadataKey] = newValue
        }
    }

    init(label: String) {
        self.label = label
    }
    init() {
        self.init(label: "default")
    }

    public func log(level: Logger.Level,
                    message: Logger.Message,
                    metadata: Logger.Metadata?,
                    file: String, function: String, line: UInt) {
        print("\(level) \(message)")
    }

    private func prettify(_ metadata: Logger.Metadata) -> String? {
        return !metadata.isEmpty ? metadata.map { "\($0)=\($1)" }.joined(separator: " ") : nil
    }

    private func timestamp() -> String {
        var buffer = [Int8](repeating: 0, count: 255)
        var timestamp = time(nil)
        let localTime = localtime(&timestamp)
        strftime(&buffer, buffer.count, "%Y-%m-%dT%H:%M:%S%z", localTime)
        return buffer.withUnsafeBufferPointer {
            $0.withMemoryRebound(to: CChar.self) {
                String(cString: $0.baseAddress!)
            }
        }
    }
}

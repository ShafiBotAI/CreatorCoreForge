import Foundation

/// Basic camera stabilization using a frame averaging filter.
/// Adjacent frames are blended together to reduce jitter.
public func stabilizeCamera(_ frames: [[[Int]]]) -> [[[Int]]] {
    guard !frames.isEmpty else { return [] }
    var output = frames
    for index in 1..<frames.count {
        output[index] = blend(frames[index - 1], frames[index])
    }
    return output
}

private func blend(_ lhs: [[Int]], _ rhs: [[Int]]) -> [[Int]] {
    guard lhs.count == rhs.count, lhs.first?.count == rhs.first?.count else {
        return rhs
    }
    var result = lhs
    for y in 0..<lhs.count {
        for x in 0..<lhs[y].count {
            result[y][x] = (lhs[y][x] + rhs[y][x]) / 2
        }
    }
    return result
}

import Foundation

/// Basic wrapper for git operations. Uses shell commands under the hood.
public struct GitSync {
    public let repoPath: String
    public init(repoPath: String) {
        self.repoPath = repoPath
    }
    
    private func run(_ args: [String]) -> Int32 {
        let task = Process()
        task.currentDirectoryURL = URL(fileURLWithPath: repoPath)
        task.executableURL = URL(fileURLWithPath: "/usr/bin/git")
        task.arguments = args
        do {
            try task.run()
            task.waitUntilExit()
            return task.terminationStatus
        } catch {
            return -1
        }
    }
    
    /// Pull latest changes.
    @discardableResult
    public func pull() -> Int32 { run(["pull"]) }
    
    /// Push local commits.
    @discardableResult
    public func push() -> Int32 { run(["push"]) }
    
    /// Commit staged files with a message.
    @discardableResult
    public func commit(message: String) -> Int32 {
        run(["commit", "-m", message])
    }
}

import Foundation

/// Experimental feature allowing alternate cutscenes.
public class WhatIfCutsceneMode {
    public init() {}

    public func generateAlternative(for scene: String) -> String {
        return "What if " + scene
    }
}

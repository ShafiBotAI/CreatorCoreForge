import Foundation

/// Builds simple quant strategies using a list of condition-action rules.
public struct QuantStrategyBuilder {
    public init() {}

    /// Generates a strategy flowchart from no-code style rules.
    /// - Parameter rules: Array of "IF condition THEN action" strings.
    /// - Returns: `StrategyFlowchart` representing the logic.
    public func build(from rules: [String]) -> StrategyFlowchart {
        let chart = StrategyFlowchart()
        for rule in rules {
            chart.addStep(rule)
        }
        return chart
    }
}

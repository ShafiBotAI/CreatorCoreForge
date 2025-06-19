import Foundation

/// Basic staking and reward tracking for TradeMind's crypto utilities.
public struct StakeEntry {
    public let account: String
    public var amount: Double
}

public final class TradeMindCryptoTokenomics {
    private var stakes: [StakeEntry] = []
    private(set) public var governanceProposals: [String] = []

    public init() {}

    /// Record a stake from an account.
    public func stake(amount: Double, from account: String) {
        if let index = stakes.firstIndex(where: { $0.account == account }) {
            stakes[index].amount += amount
        } else {
            stakes.append(StakeEntry(account: account, amount: amount))
        }
    }

    /// Calculate total amount staked across all accounts.
    public func totalStaked() -> Double {
        stakes.reduce(0) { $0 + $1.amount }
    }

    /// Submit a governance proposal description.
    public func submitProposal(_ text: String) {
        governanceProposals.append(text)
    }
}


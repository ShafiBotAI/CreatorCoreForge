import XCTest
@testable import CreatorCoreForge

final class AIEngineFactoryTests: XCTestCase {
    func testDefaultsToOpenAIService() {
        let originalUseLocal = getenv("USE_LOCAL_AI")
        let originalKey = getenv("OPENAI_API_KEY")
        unsetenv("USE_LOCAL_AI")
        setenv("OPENAI_API_KEY", "TESTKEY", 1)
        let engine = AIEngineFactory.defaultEngine()
        XCTAssertTrue(engine is OpenAIService)
        if let value = originalUseLocal { setenv("USE_LOCAL_AI", value, 1) } else { unsetenv("USE_LOCAL_AI") }
        if let value = originalKey { setenv("OPENAI_API_KEY", value, 1) } else { unsetenv("OPENAI_API_KEY") }
    }

    func testUsesLocalEngineWhenEnvSet() {
        let originalKey = getenv("OPENAI_API_KEY")
        setenv("USE_LOCAL_AI", "1", 1)
        setenv("OPENAI_API_KEY", "TESTKEY", 1)
        let engine = AIEngineFactory.defaultEngine()
        XCTAssertTrue(engine is LocalAIEnginePro)
        unsetenv("USE_LOCAL_AI")
        if let value = originalKey { setenv("OPENAI_API_KEY", value, 1) } else { unsetenv("OPENAI_API_KEY") }
    }
}

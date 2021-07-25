// Generated using Sourcery 1.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Generated with SwiftyMocky 4.0.4

@testable import Dokoiko
import Foundation
import RxBlocking
import RxCocoa
import RxSwift
import SwiftyMocky
import XCTest

// MARK: - AppDataGatewayProtocol

open class AppDataGatewayProtocolMock: AppDataGatewayProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var firstLaunchFlag: Single<Bool> { invocations.append(.p_firstLaunchFlag_get); return __p_firstLaunchFlag ?? givenGetterValue(.p_firstLaunchFlag_get, "AppDataGatewayProtocolMock - stub value for firstLaunchFlag was not defined") }

    private var __p_firstLaunchFlag: (Single<Bool>)?

    public var searchConditionPrefectures: Single<SearchConditionPrefectures?> { invocations.append(.p_searchConditionPrefectures_get); return __p_searchConditionPrefectures ?? givenGetterValue(.p_searchConditionPrefectures_get, "AppDataGatewayProtocolMock - stub value for searchConditionPrefectures was not defined") }

    private var __p_searchConditionPrefectures: (Single<SearchConditionPrefectures?>)?

    fileprivate enum MethodType {
        case p_firstLaunchFlag_get
        case p_searchConditionPrefectures_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) { case (.p_firstLaunchFlag_get, .p_firstLaunchFlag_get): return Matcher.ComparisonResult.match
            case (.p_searchConditionPrefectures_get, .p_searchConditionPrefectures_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .p_firstLaunchFlag_get: return 0
            case .p_searchConditionPrefectures_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .p_firstLaunchFlag_get: return "[get] .firstLaunchFlag"
            case .p_searchConditionPrefectures_get: return "[get] .searchConditionPrefectures"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func firstLaunchFlag(getter defaultValue: Single<Bool>...) -> PropertyStub {
            Given(method: .p_firstLaunchFlag_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func searchConditionPrefectures(getter defaultValue: Single<SearchConditionPrefectures?>...) -> PropertyStub {
            Given(method: .p_searchConditionPrefectures_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static var firstLaunchFlag: Verify { Verify(method: .p_firstLaunchFlag_get) }
        public static var searchConditionPrefectures: Verify { Verify(method: .p_searchConditionPrefectures_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - DatabaseProtocol

open class DatabaseProtocolMock: DatabaseProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    open func saveCitySearchResult(prefCode: Int, cityName: String, cityCode: String?, lat: Double?, lng: Double?) -> Single<Result<SearchResultObject, DataBaseError>> {
        addInvocation(.m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(Parameter<Int>.value(prefCode), Parameter<String>.value(cityName), Parameter<String?>.value(cityCode), Parameter<Double?>.value(lat), Parameter<Double?>.value(lng)))
        let perform = methodPerformValue(.m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(Parameter<Int>.value(prefCode), Parameter<String>.value(cityName), Parameter<String?>.value(cityCode), Parameter<Double?>.value(lat), Parameter<Double?>.value(lng))) as? (Int, String, String?, Double?, Double?) -> Void
        perform?(prefCode, cityName, cityCode, lat, lng)
        var __value: Single<Result<SearchResultObject, DataBaseError>>
        do {
            __value = try methodReturnValue(.m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(Parameter<Int>.value(prefCode), Parameter<String>.value(cityName), Parameter<String?>.value(cityCode), Parameter<Double?>.value(lat), Parameter<Double?>.value(lng))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for saveCitySearchResult(prefCode: Int, cityName: String, cityCode: String?, lat: Double?, lng: Double?). Use given")
            Failure("Stub return value not specified for saveCitySearchResult(prefCode: Int, cityName: String, cityCode: String?, lat: Double?, lng: Double?). Use given")
        }
        return __value
    }

    open func setCityLocation(id: String, lat: Double, lng: Double) -> Single<Result<SearchResultObject, DataBaseError>> {
        addInvocation(.m_setCityLocation__id_idlat_latlng_lng(Parameter<String>.value(id), Parameter<Double>.value(lat), Parameter<Double>.value(lng)))
        let perform = methodPerformValue(.m_setCityLocation__id_idlat_latlng_lng(Parameter<String>.value(id), Parameter<Double>.value(lat), Parameter<Double>.value(lng))) as? (String, Double, Double) -> Void
        perform?(id, lat, lng)
        var __value: Single<Result<SearchResultObject, DataBaseError>>
        do {
            __value = try methodReturnValue(.m_setCityLocation__id_idlat_latlng_lng(Parameter<String>.value(id), Parameter<Double>.value(lat), Parameter<Double>.value(lng))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for setCityLocation(id: String, lat: Double, lng: Double). Use given")
            Failure("Stub return value not specified for setCityLocation(id: String, lat: Double, lng: Double). Use given")
        }
        return __value
    }

    open func getCitySearchResult() -> Single<Result<[SearchResultObject], DataBaseError>> {
        addInvocation(.m_getCitySearchResult)
        let perform = methodPerformValue(.m_getCitySearchResult) as? () -> Void
        perform?()
        var __value: Single<Result<[SearchResultObject], DataBaseError>>
        do {
            __value = try methodReturnValue(.m_getCitySearchResult).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getCitySearchResult(). Use given")
            Failure("Stub return value not specified for getCitySearchResult(). Use given")
        }
        return __value
    }

    fileprivate enum MethodType {
        case m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(Parameter<Int>, Parameter<String>, Parameter<String?>, Parameter<Double?>, Parameter<Double?>)
        case m_setCityLocation__id_idlat_latlng_lng(Parameter<String>, Parameter<Double>, Parameter<Double>)
        case m_getCitySearchResult

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(lhsPrefcode, lhsCityname, lhsCitycode, lhsLat, lhsLng), .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(rhsPrefcode, rhsCityname, rhsCitycode, rhsLat, rhsLng)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPrefcode, rhs: rhsPrefcode, with: matcher), lhsPrefcode, rhsPrefcode, "prefCode"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCityname, rhs: rhsCityname, with: matcher), lhsCityname, rhsCityname, "cityName"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCitycode, rhs: rhsCitycode, with: matcher), lhsCitycode, rhsCitycode, "cityCode"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLat, rhs: rhsLat, with: matcher), lhsLat, rhsLat, "lat"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLng, rhs: rhsLng, with: matcher), lhsLng, rhsLng, "lng"))
                return Matcher.ComparisonResult(results)

            case let (.m_setCityLocation__id_idlat_latlng_lng(lhsId, lhsLat, lhsLng), .m_setCityLocation__id_idlat_latlng_lng(rhsId, rhsLat, rhsLng)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "id"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLat, rhs: rhsLat, with: matcher), lhsLat, rhsLat, "lat"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLng, rhs: rhsLng, with: matcher), lhsLng, rhsLng, "lng"))
                return Matcher.ComparisonResult(results)

            case (.m_getCitySearchResult, .m_getCitySearchResult): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(p0, p1, p2, p3, p4): return p0.intValue + p1.intValue + p2.intValue + p3.intValue + p4.intValue
            case let .m_setCityLocation__id_idlat_latlng_lng(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case .m_getCitySearchResult: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng: return ".saveCitySearchResult(prefCode:cityName:cityCode:lat:lng:)"
            case .m_setCityLocation__id_idlat_latlng_lng: return ".setCityLocation(id:lat:lng:)"
            case .m_getCitySearchResult: return ".getCitySearchResult()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func saveCitySearchResult(prefCode: Parameter<Int>, cityName: Parameter<String>, cityCode: Parameter<String?>, lat: Parameter<Double?>, lng: Parameter<Double?>, willReturn: Single<Result<SearchResultObject, DataBaseError>>...) -> MethodStub {
            Given(method: .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(prefCode, cityName, cityCode, lat, lng), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func setCityLocation(id: Parameter<String>, lat: Parameter<Double>, lng: Parameter<Double>, willReturn: Single<Result<SearchResultObject, DataBaseError>>...) -> MethodStub {
            Given(method: .m_setCityLocation__id_idlat_latlng_lng(id, lat, lng), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getCitySearchResult(willReturn: Single<Result<[SearchResultObject], DataBaseError>>...) -> MethodStub {
            Given(method: .m_getCitySearchResult, products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func saveCitySearchResult(prefCode: Parameter<Int>, cityName: Parameter<String>, cityCode: Parameter<String?>, lat: Parameter<Double?>, lng: Parameter<Double?>, willProduce: (Stubber<Single<Result<SearchResultObject, DataBaseError>>>) -> Void) -> MethodStub {
            let willReturn: [Single<Result<SearchResultObject, DataBaseError>>] = []
            let given: Given = { Given(method: .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(prefCode, cityName, cityCode, lat, lng), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<Result<SearchResultObject, DataBaseError>>.self)
            willProduce(stubber)
            return given
        }

        public static func setCityLocation(id: Parameter<String>, lat: Parameter<Double>, lng: Parameter<Double>, willProduce: (Stubber<Single<Result<SearchResultObject, DataBaseError>>>) -> Void) -> MethodStub {
            let willReturn: [Single<Result<SearchResultObject, DataBaseError>>] = []
            let given: Given = { Given(method: .m_setCityLocation__id_idlat_latlng_lng(id, lat, lng), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<Result<SearchResultObject, DataBaseError>>.self)
            willProduce(stubber)
            return given
        }

        public static func getCitySearchResult(willProduce: (Stubber<Single<Result<[SearchResultObject], DataBaseError>>>) -> Void) -> MethodStub {
            let willReturn: [Single<Result<[SearchResultObject], DataBaseError>>] = []
            let given: Given = { Given(method: .m_getCitySearchResult, products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<Result<[SearchResultObject], DataBaseError>>.self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func saveCitySearchResult(prefCode: Parameter<Int>, cityName: Parameter<String>, cityCode: Parameter<String?>, lat: Parameter<Double?>, lng: Parameter<Double?>) -> Verify { Verify(method: .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(prefCode, cityName, cityCode, lat, lng)) }
        public static func setCityLocation(id: Parameter<String>, lat: Parameter<Double>, lng: Parameter<Double>) -> Verify { Verify(method: .m_setCityLocation__id_idlat_latlng_lng(id, lat, lng)) }
        public static func getCitySearchResult() -> Verify { Verify(method: .m_getCitySearchResult) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func saveCitySearchResult(prefCode: Parameter<Int>, cityName: Parameter<String>, cityCode: Parameter<String?>, lat: Parameter<Double?>, lng: Parameter<Double?>, perform: @escaping (Int, String, String?, Double?, Double?) -> Void) -> Perform {
            Perform(method: .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(prefCode, cityName, cityCode, lat, lng), performs: perform)
        }

        public static func setCityLocation(id: Parameter<String>, lat: Parameter<Double>, lng: Parameter<Double>, perform: @escaping (String, Double, Double) -> Void) -> Perform {
            Perform(method: .m_setCityLocation__id_idlat_latlng_lng(id, lat, lng), performs: perform)
        }

        public static func getCitySearchResult(perform: @escaping () -> Void) -> Perform {
            Perform(method: .m_getCitySearchResult, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - GeoDBGatewayProtocol

open class GeoDBGatewayProtocolMock: GeoDBGatewayProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    open func getCitiesInArea(lat: Double, lng: Double, radiusKM: Double) -> Single<ApiResponseEntity<GeoDBCitiesEntity>> {
        addInvocation(.m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Double>.value(radiusKM)))
        let perform = methodPerformValue(.m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Double>.value(radiusKM))) as? (Double, Double, Double) -> Void
        perform?(lat, lng, radiusKM)
        var __value: Single<ApiResponseEntity<GeoDBCitiesEntity>>
        do {
            __value = try methodReturnValue(.m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Double>.value(radiusKM))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getCitiesInArea(lat: Double, lng: Double, radiusKM: Double). Use given")
            Failure("Stub return value not specified for getCitiesInArea(lat: Double, lng: Double, radiusKM: Double). Use given")
        }
        return __value
    }

    fileprivate enum MethodType {
        case m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(Parameter<Double>, Parameter<Double>, Parameter<Double>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(lhsLat, lhsLng, lhsRadiuskm), .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(rhsLat, rhsLng, rhsRadiuskm)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLat, rhs: rhsLat, with: matcher), lhsLat, rhsLat, "lat"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLng, rhs: rhsLng, with: matcher), lhsLng, rhsLng, "lng"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRadiuskm, rhs: rhsRadiuskm, with: matcher), lhsRadiuskm, rhsRadiuskm, "radiusKM"))
                return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM: return ".getCitiesInArea(lat:lng:radiusKM:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func getCitiesInArea(lat: Parameter<Double>, lng: Parameter<Double>, radiusKM: Parameter<Double>, willReturn: Single<ApiResponseEntity<GeoDBCitiesEntity>>...) -> MethodStub {
            Given(method: .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(lat, lng, radiusKM), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getCitiesInArea(lat: Parameter<Double>, lng: Parameter<Double>, radiusKM: Parameter<Double>, willProduce: (Stubber<Single<ApiResponseEntity<GeoDBCitiesEntity>>>) -> Void) -> MethodStub {
            let willReturn: [Single<ApiResponseEntity<GeoDBCitiesEntity>>] = []
            let given: Given = { Given(method: .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(lat, lng, radiusKM), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<ApiResponseEntity<GeoDBCitiesEntity>>.self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getCitiesInArea(lat: Parameter<Double>, lng: Parameter<Double>, radiusKM: Parameter<Double>) -> Verify { Verify(method: .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(lat, lng, radiusKM)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getCitiesInArea(lat: Parameter<Double>, lng: Parameter<Double>, radiusKM: Parameter<Double>, perform: @escaping (Double, Double, Double) -> Void) -> Perform {
            Perform(method: .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(lat, lng, radiusKM), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - GeoDBUseCaseProtocol

open class GeoDBUseCaseProtocolMock: GeoDBUseCaseProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    open func getCitiesInArea(lat: Double, lng: Double, radiusKM: Double) -> Single<ApiResponseEntity<GeoDBCitiesEntity>> {
        addInvocation(.m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Double>.value(radiusKM)))
        let perform = methodPerformValue(.m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Double>.value(radiusKM))) as? (Double, Double, Double) -> Void
        perform?(lat, lng, radiusKM)
        var __value: Single<ApiResponseEntity<GeoDBCitiesEntity>>
        do {
            __value = try methodReturnValue(.m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Double>.value(radiusKM))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getCitiesInArea(lat: Double, lng: Double, radiusKM: Double). Use given")
            Failure("Stub return value not specified for getCitiesInArea(lat: Double, lng: Double, radiusKM: Double). Use given")
        }
        return __value
    }

    fileprivate enum MethodType {
        case m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(Parameter<Double>, Parameter<Double>, Parameter<Double>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(lhsLat, lhsLng, lhsRadiuskm), .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(rhsLat, rhsLng, rhsRadiuskm)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLat, rhs: rhsLat, with: matcher), lhsLat, rhsLat, "lat"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLng, rhs: rhsLng, with: matcher), lhsLng, rhsLng, "lng"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRadiuskm, rhs: rhsRadiuskm, with: matcher), lhsRadiuskm, rhsRadiuskm, "radiusKM"))
                return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM: return ".getCitiesInArea(lat:lng:radiusKM:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func getCitiesInArea(lat: Parameter<Double>, lng: Parameter<Double>, radiusKM: Parameter<Double>, willReturn: Single<ApiResponseEntity<GeoDBCitiesEntity>>...) -> MethodStub {
            Given(method: .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(lat, lng, radiusKM), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getCitiesInArea(lat: Parameter<Double>, lng: Parameter<Double>, radiusKM: Parameter<Double>, willProduce: (Stubber<Single<ApiResponseEntity<GeoDBCitiesEntity>>>) -> Void) -> MethodStub {
            let willReturn: [Single<ApiResponseEntity<GeoDBCitiesEntity>>] = []
            let given: Given = { Given(method: .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(lat, lng, radiusKM), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<ApiResponseEntity<GeoDBCitiesEntity>>.self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getCitiesInArea(lat: Parameter<Double>, lng: Parameter<Double>, radiusKM: Parameter<Double>) -> Verify { Verify(method: .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(lat, lng, radiusKM)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getCitiesInArea(lat: Parameter<Double>, lng: Parameter<Double>, radiusKM: Parameter<Double>, perform: @escaping (Double, Double, Double) -> Void) -> Perform {
            Perform(method: .m_getCitiesInArea__lat_latlng_lngradiusKM_radiusKM(lat, lng, radiusKM), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - LocalSearchAPIClientProtocol

open class LocalSearchAPIClientProtocolMock: LocalSearchAPIClientProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    open func getSpot(
        cityCode: String,
        startIndex: Int,
        category: LocalSearchAPICategoryType
    ) -> Single<ApiResponseEntity<LocalSearchAPIResponse>> {
        addInvocation(.m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(Parameter<String>.value(cityCode), Parameter<Int>.value(startIndex), Parameter<LocalSearchAPICategoryType>.value(category)))
        let perform = methodPerformValue(.m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(Parameter<String>.value(cityCode), Parameter<Int>.value(startIndex), Parameter<LocalSearchAPICategoryType>.value(category))) as? (String, Int, LocalSearchAPICategoryType) -> Void
        perform?(cityCode, startIndex, category)
        var __value: Single<ApiResponseEntity<LocalSearchAPIResponse>>
        do {
            __value = try methodReturnValue(.m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(Parameter<String>.value(cityCode), Parameter<Int>.value(startIndex), Parameter<LocalSearchAPICategoryType>.value(category))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getSpot(cityCode: String, startIndex: Int, category: LocalSearchAPICategoryType). Use given")
            Failure("Stub return value not specified for getSpot(cityCode: String, startIndex: Int, category: LocalSearchAPICategoryType). Use given")
        }
        return __value
    }

    open func getSpot(
        lat: Double,
        lng: Double,
        startIndex: Int,
        category: LocalSearchAPICategoryType
    ) -> Single<ApiResponseEntity<LocalSearchAPIResponse>> {
        addInvocation(.m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Int>.value(startIndex), Parameter<LocalSearchAPICategoryType>.value(category)))
        let perform = methodPerformValue(.m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Int>.value(startIndex), Parameter<LocalSearchAPICategoryType>.value(category))) as? (Double, Double, Int, LocalSearchAPICategoryType) -> Void
        perform?(lat, lng, startIndex, category)
        var __value: Single<ApiResponseEntity<LocalSearchAPIResponse>>
        do {
            __value = try methodReturnValue(.m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Int>.value(startIndex), Parameter<LocalSearchAPICategoryType>.value(category))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getSpot(lat: Double, lng: Double, startIndex: Int, category: LocalSearchAPICategoryType). Use given")
            Failure("Stub return value not specified for getSpot(lat: Double, lng: Double, startIndex: Int, category: LocalSearchAPICategoryType). Use given")
        }
        return __value
    }

    open func request<T: Codable>(request: Request) -> Single<ApiResponseEntity<T>> {
        addInvocation(.m_request__request_request(Parameter<Request>.value(request)))
        let perform = methodPerformValue(.m_request__request_request(Parameter<Request>.value(request))) as? (Request) -> Void
        perform?(request)
        var __value: Single<ApiResponseEntity<T>>
        do {
            __value = try methodReturnValue(.m_request__request_request(Parameter<Request>.value(request))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for request<T: Codable>(request: Request). Use given")
            Failure("Stub return value not specified for request<T: Codable>(request: Request). Use given")
        }
        return __value
    }

    open func getDefaultUrlRequest(request: Request) -> URLRequest? {
        addInvocation(.m_getDefaultUrlRequest__request_request(Parameter<Request>.value(request)))
        let perform = methodPerformValue(.m_getDefaultUrlRequest__request_request(Parameter<Request>.value(request))) as? (Request) -> Void
        perform?(request)
        var __value: URLRequest?
        do {
            __value = try methodReturnValue(.m_getDefaultUrlRequest__request_request(Parameter<Request>.value(request))).casted()
        } catch {
            // do nothing
        }
        return __value
    }

    fileprivate enum MethodType {
        case m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(Parameter<String>, Parameter<Int>, Parameter<LocalSearchAPICategoryType>)
        case m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(Parameter<Double>, Parameter<Double>, Parameter<Int>, Parameter<LocalSearchAPICategoryType>)
        case m_request__request_request(Parameter<Request>)
        case m_getDefaultUrlRequest__request_request(Parameter<Request>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(lhsCitycode, lhsStartindex, lhsCategory), .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(rhsCitycode, rhsStartindex, rhsCategory)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCitycode, rhs: rhsCitycode, with: matcher), lhsCitycode, rhsCitycode, "cityCode"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsStartindex, rhs: rhsStartindex, with: matcher), lhsStartindex, rhsStartindex, "startIndex"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCategory, rhs: rhsCategory, with: matcher), lhsCategory, rhsCategory, "category"))
                return Matcher.ComparisonResult(results)

            case let (.m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lhsLat, lhsLng, lhsStartindex, lhsCategory), .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(rhsLat, rhsLng, rhsStartindex, rhsCategory)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLat, rhs: rhsLat, with: matcher), lhsLat, rhsLat, "lat"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLng, rhs: rhsLng, with: matcher), lhsLng, rhsLng, "lng"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsStartindex, rhs: rhsStartindex, with: matcher), lhsStartindex, rhsStartindex, "startIndex"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCategory, rhs: rhsCategory, with: matcher), lhsCategory, rhsCategory, "category"))
                return Matcher.ComparisonResult(results)

            case let (.m_request__request_request(lhsRequest), .m_request__request_request(rhsRequest)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRequest, rhs: rhsRequest, with: matcher), lhsRequest, rhsRequest, "request"))
                return Matcher.ComparisonResult(results)

            case let (.m_getDefaultUrlRequest__request_request(lhsRequest), .m_getDefaultUrlRequest__request_request(rhsRequest)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRequest, rhs: rhsRequest, with: matcher), lhsRequest, rhsRequest, "request"))
                return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case let .m_request__request_request(p0): return p0.intValue
            case let .m_getDefaultUrlRequest__request_request(p0): return p0.intValue
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category: return ".getSpot(cityCode:startIndex:category:)"
            case .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category: return ".getSpot(lat:lng:startIndex:category:)"
            case .m_request__request_request: return ".request(request:)"
            case .m_getDefaultUrlRequest__request_request: return ".getDefaultUrlRequest(request:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func getSpot(cityCode: Parameter<String>, startIndex: Parameter<Int>, category: Parameter<LocalSearchAPICategoryType>, willReturn: Single<ApiResponseEntity<LocalSearchAPIResponse>>...) -> MethodStub {
            Given(method: .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(cityCode, startIndex, category), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getSpot(lat: Parameter<Double>, lng: Parameter<Double>, startIndex: Parameter<Int>, category: Parameter<LocalSearchAPICategoryType>, willReturn: Single<ApiResponseEntity<LocalSearchAPIResponse>>...) -> MethodStub {
            Given(method: .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lat, lng, startIndex, category), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func request<T: Codable>(request: Parameter<Request>, willReturn: Single<ApiResponseEntity<T>>...) -> MethodStub {
            Given(method: .m_request__request_request(request), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getDefaultUrlRequest(request: Parameter<Request>, willReturn: URLRequest?...) -> MethodStub {
            Given(method: .m_getDefaultUrlRequest__request_request(request), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getSpot(cityCode: Parameter<String>, startIndex: Parameter<Int>, category: Parameter<LocalSearchAPICategoryType>, willProduce: (Stubber<Single<ApiResponseEntity<LocalSearchAPIResponse>>>) -> Void) -> MethodStub {
            let willReturn: [Single<ApiResponseEntity<LocalSearchAPIResponse>>] = []
            let given: Given = { Given(method: .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(cityCode, startIndex, category), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<ApiResponseEntity<LocalSearchAPIResponse>>.self)
            willProduce(stubber)
            return given
        }

        public static func getSpot(lat: Parameter<Double>, lng: Parameter<Double>, startIndex: Parameter<Int>, category: Parameter<LocalSearchAPICategoryType>, willProduce: (Stubber<Single<ApiResponseEntity<LocalSearchAPIResponse>>>) -> Void) -> MethodStub {
            let willReturn: [Single<ApiResponseEntity<LocalSearchAPIResponse>>] = []
            let given: Given = { Given(method: .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lat, lng, startIndex, category), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<ApiResponseEntity<LocalSearchAPIResponse>>.self)
            willProduce(stubber)
            return given
        }

        public static func request<T: Codable>(request: Parameter<Request>, willProduce: (Stubber<Single<ApiResponseEntity<T>>>) -> Void) -> MethodStub {
            let willReturn: [Single<ApiResponseEntity<T>>] = []
            let given: Given = { Given(method: .m_request__request_request(request), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<ApiResponseEntity<T>>.self)
            willProduce(stubber)
            return given
        }

        public static func getDefaultUrlRequest(request: Parameter<Request>, willProduce: (Stubber<URLRequest?>) -> Void) -> MethodStub {
            let willReturn: [URLRequest?] = []
            let given: Given = { Given(method: .m_getDefaultUrlRequest__request_request(request), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: (URLRequest?).self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getSpot(cityCode: Parameter<String>, startIndex: Parameter<Int>, category: Parameter<LocalSearchAPICategoryType>) -> Verify { Verify(method: .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(cityCode, startIndex, category)) }
        public static func getSpot(lat: Parameter<Double>, lng: Parameter<Double>, startIndex: Parameter<Int>, category: Parameter<LocalSearchAPICategoryType>) -> Verify { Verify(method: .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lat, lng, startIndex, category)) }
        public static func request(request: Parameter<Request>) -> Verify { Verify(method: .m_request__request_request(request)) }
        public static func getDefaultUrlRequest(request: Parameter<Request>) -> Verify { Verify(method: .m_getDefaultUrlRequest__request_request(request)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getSpot(cityCode: Parameter<String>, startIndex: Parameter<Int>, category: Parameter<LocalSearchAPICategoryType>, perform: @escaping (String, Int, LocalSearchAPICategoryType) -> Void) -> Perform {
            Perform(method: .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(cityCode, startIndex, category), performs: perform)
        }

        public static func getSpot(lat: Parameter<Double>, lng: Parameter<Double>, startIndex: Parameter<Int>, category: Parameter<LocalSearchAPICategoryType>, perform: @escaping (Double, Double, Int, LocalSearchAPICategoryType) -> Void) -> Perform {
            Perform(method: .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lat, lng, startIndex, category), performs: perform)
        }

        public static func request(request: Parameter<Request>, perform: @escaping (Request) -> Void) -> Perform {
            Perform(method: .m_request__request_request(request), performs: perform)
        }

        public static func getDefaultUrlRequest(request: Parameter<Request>, perform: @escaping (Request) -> Void) -> Perform {
            Perform(method: .m_getDefaultUrlRequest__request_request(request), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - LocalSearchGatewayProtocol

open class LocalSearchGatewayProtocolMock: LocalSearchGatewayProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    open func getSpot(
        cityCode: String,
        startIndex: Int,
        category: SpotCategory
    ) -> Single<ApiResponseEntity<[RecommendSpotEntity]>> {
        addInvocation(.m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(Parameter<String>.value(cityCode), Parameter<Int>.value(startIndex), Parameter<SpotCategory>.value(category)))
        let perform = methodPerformValue(.m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(Parameter<String>.value(cityCode), Parameter<Int>.value(startIndex), Parameter<SpotCategory>.value(category))) as? (String, Int, SpotCategory) -> Void
        perform?(cityCode, startIndex, category)
        var __value: Single<ApiResponseEntity<[RecommendSpotEntity]>>
        do {
            __value = try methodReturnValue(.m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(Parameter<String>.value(cityCode), Parameter<Int>.value(startIndex), Parameter<SpotCategory>.value(category))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getSpot(cityCode: String, startIndex: Int, category: SpotCategory). Use given")
            Failure("Stub return value not specified for getSpot(cityCode: String, startIndex: Int, category: SpotCategory). Use given")
        }
        return __value
    }

    open func getSpot(
        lat: Double,
        lng: Double,
        startIndex: Int,
        category: SpotCategory
    ) -> Single<ApiResponseEntity<[RecommendSpotEntity]>> {
        addInvocation(.m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Int>.value(startIndex), Parameter<SpotCategory>.value(category)))
        let perform = methodPerformValue(.m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Int>.value(startIndex), Parameter<SpotCategory>.value(category))) as? (Double, Double, Int, SpotCategory) -> Void
        perform?(lat, lng, startIndex, category)
        var __value: Single<ApiResponseEntity<[RecommendSpotEntity]>>
        do {
            __value = try methodReturnValue(.m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Int>.value(startIndex), Parameter<SpotCategory>.value(category))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getSpot(lat: Double, lng: Double, startIndex: Int, category: SpotCategory). Use given")
            Failure("Stub return value not specified for getSpot(lat: Double, lng: Double, startIndex: Int, category: SpotCategory). Use given")
        }
        return __value
    }

    fileprivate enum MethodType {
        case m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(Parameter<String>, Parameter<Int>, Parameter<SpotCategory>)
        case m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(Parameter<Double>, Parameter<Double>, Parameter<Int>, Parameter<SpotCategory>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(lhsCitycode, lhsStartindex, lhsCategory), .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(rhsCitycode, rhsStartindex, rhsCategory)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCitycode, rhs: rhsCitycode, with: matcher), lhsCitycode, rhsCitycode, "cityCode"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsStartindex, rhs: rhsStartindex, with: matcher), lhsStartindex, rhsStartindex, "startIndex"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCategory, rhs: rhsCategory, with: matcher), lhsCategory, rhsCategory, "category"))
                return Matcher.ComparisonResult(results)

            case let (.m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lhsLat, lhsLng, lhsStartindex, lhsCategory), .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(rhsLat, rhsLng, rhsStartindex, rhsCategory)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLat, rhs: rhsLat, with: matcher), lhsLat, rhsLat, "lat"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLng, rhs: rhsLng, with: matcher), lhsLng, rhsLng, "lng"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsStartindex, rhs: rhsStartindex, with: matcher), lhsStartindex, rhsStartindex, "startIndex"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCategory, rhs: rhsCategory, with: matcher), lhsCategory, rhsCategory, "category"))
                return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category: return ".getSpot(cityCode:startIndex:category:)"
            case .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category: return ".getSpot(lat:lng:startIndex:category:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func getSpot(cityCode: Parameter<String>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>, willReturn: Single<ApiResponseEntity<[RecommendSpotEntity]>>...) -> MethodStub {
            Given(method: .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(cityCode, startIndex, category), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getSpot(lat: Parameter<Double>, lng: Parameter<Double>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>, willReturn: Single<ApiResponseEntity<[RecommendSpotEntity]>>...) -> MethodStub {
            Given(method: .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lat, lng, startIndex, category), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getSpot(cityCode: Parameter<String>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>, willProduce: (Stubber<Single<ApiResponseEntity<[RecommendSpotEntity]>>>) -> Void) -> MethodStub {
            let willReturn: [Single<ApiResponseEntity<[RecommendSpotEntity]>>] = []
            let given: Given = { Given(method: .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(cityCode, startIndex, category), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<ApiResponseEntity<[RecommendSpotEntity]>>.self)
            willProduce(stubber)
            return given
        }

        public static func getSpot(lat: Parameter<Double>, lng: Parameter<Double>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>, willProduce: (Stubber<Single<ApiResponseEntity<[RecommendSpotEntity]>>>) -> Void) -> MethodStub {
            let willReturn: [Single<ApiResponseEntity<[RecommendSpotEntity]>>] = []
            let given: Given = { Given(method: .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lat, lng, startIndex, category), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<ApiResponseEntity<[RecommendSpotEntity]>>.self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getSpot(cityCode: Parameter<String>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>) -> Verify { Verify(method: .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(cityCode, startIndex, category)) }
        public static func getSpot(lat: Parameter<Double>, lng: Parameter<Double>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>) -> Verify { Verify(method: .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lat, lng, startIndex, category)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getSpot(cityCode: Parameter<String>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>, perform: @escaping (String, Int, SpotCategory) -> Void) -> Perform {
            Perform(method: .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(cityCode, startIndex, category), performs: perform)
        }

        public static func getSpot(lat: Parameter<Double>, lng: Parameter<Double>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>, perform: @escaping (Double, Double, Int, SpotCategory) -> Void) -> Perform {
            Perform(method: .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lat, lng, startIndex, category), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - LocationGatewayProtocol

open class LocationGatewayProtocolMock: LocationGatewayProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    open func getLocationAuth() -> Observable<LocationAuthEntity> {
        addInvocation(.m_getLocationAuth)
        let perform = methodPerformValue(.m_getLocationAuth) as? () -> Void
        perform?()
        var __value: Observable<LocationAuthEntity>
        do {
            __value = try methodReturnValue(.m_getLocationAuth).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getLocationAuth(). Use given")
            Failure("Stub return value not specified for getLocationAuth(). Use given")
        }
        return __value
    }

    open func getCurrentLocation() -> Observable<(lat: Double, lng: Double)> {
        addInvocation(.m_getCurrentLocation)
        let perform = methodPerformValue(.m_getCurrentLocation) as? () -> Void
        perform?()
        var __value: Observable<(lat: Double, lng: Double)>
        do {
            __value = try methodReturnValue(.m_getCurrentLocation).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getCurrentLocation(). Use given")
            Failure("Stub return value not specified for getCurrentLocation(). Use given")
        }
        return __value
    }

    fileprivate enum MethodType {
        case m_getLocationAuth
        case m_getCurrentLocation

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getLocationAuth, .m_getLocationAuth): return .match

            case (.m_getCurrentLocation, .m_getCurrentLocation): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getLocationAuth: return 0
            case .m_getCurrentLocation: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_getLocationAuth: return ".getLocationAuth()"
            case .m_getCurrentLocation: return ".getCurrentLocation()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func getLocationAuth(willReturn: Observable<LocationAuthEntity>...) -> MethodStub {
            Given(method: .m_getLocationAuth, products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getCurrentLocation(willReturn: Observable<(lat: Double, lng: Double)>...) -> MethodStub {
            Given(method: .m_getCurrentLocation, products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getLocationAuth(willProduce: (Stubber<Observable<LocationAuthEntity>>) -> Void) -> MethodStub {
            let willReturn: [Observable<LocationAuthEntity>] = []
            let given: Given = { Given(method: .m_getLocationAuth, products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Observable<LocationAuthEntity>.self)
            willProduce(stubber)
            return given
        }

        public static func getCurrentLocation(willProduce: (Stubber<Observable<(lat: Double, lng: Double)>>) -> Void) -> MethodStub {
            let willReturn: [Observable<(lat: Double, lng: Double)>] = []
            let given: Given = { Given(method: .m_getCurrentLocation, products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Observable<(lat: Double, lng: Double)>.self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getLocationAuth() -> Verify { Verify(method: .m_getLocationAuth) }
        public static func getCurrentLocation() -> Verify { Verify(method: .m_getCurrentLocation) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getLocationAuth(perform: @escaping () -> Void) -> Perform {
            Perform(method: .m_getLocationAuth, performs: perform)
        }

        public static func getCurrentLocation(perform: @escaping () -> Void) -> Perform {
            Perform(method: .m_getCurrentLocation, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - MainRouterProtocol

open class MainRouterProtocolMock: MainRouterProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var window: UIWindow? { invocations.append(.p_window_get); return __p_window ?? optionalGivenGetterValue(.p_window_get, "MainRouterProtocolMock - stub value for window was not defined") }

    private var __p_window: (UIWindow)?

    open func navigate(to destination: MainNavigationDestination) {
        addInvocation(.m_navigate__to_destination(Parameter<MainNavigationDestination>.value(destination)))
        let perform = methodPerformValue(.m_navigate__to_destination(Parameter<MainNavigationDestination>.value(destination))) as? (MainNavigationDestination) -> Void
        perform?(destination)
    }

    open func rootNavigation(to destination: BaseRouterNavigationDestination) {
        addInvocation(.m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>.value(destination)))
        let perform = methodPerformValue(.m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>.value(destination))) as? (BaseRouterNavigationDestination) -> Void
        perform?(destination)
    }

    fileprivate enum MethodType {
        case m_navigate__to_destination(Parameter<MainNavigationDestination>)
        case m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>)
        case p_window_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_navigate__to_destination(lhsDestination), .m_navigate__to_destination(rhsDestination)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDestination, rhs: rhsDestination, with: matcher), lhsDestination, rhsDestination, "to destination"))
                return Matcher.ComparisonResult(results)

            case let (.m_rootNavigation__to_destination(lhsDestination), .m_rootNavigation__to_destination(rhsDestination)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDestination, rhs: rhsDestination, with: matcher), lhsDestination, rhsDestination, "to destination"))
                return Matcher.ComparisonResult(results)
            case (.p_window_get, .p_window_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_navigate__to_destination(p0): return p0.intValue
            case let .m_rootNavigation__to_destination(p0): return p0.intValue
            case .p_window_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_navigate__to_destination: return ".navigate(to:)"
            case .m_rootNavigation__to_destination: return ".rootNavigation(to:)"
            case .p_window_get: return "[get] .window"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func window(getter defaultValue: UIWindow?...) -> PropertyStub {
            Given(method: .p_window_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func navigate(to destination: Parameter<MainNavigationDestination>) -> Verify { Verify(method: .m_navigate__to_destination(destination)) }
        public static func rootNavigation(to destination: Parameter<BaseRouterNavigationDestination>) -> Verify { Verify(method: .m_rootNavigation__to_destination(destination)) }
        public static var window: Verify { Verify(method: .p_window_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func navigate(to destination: Parameter<MainNavigationDestination>, perform: @escaping (MainNavigationDestination) -> Void) -> Perform {
            Perform(method: .m_navigate__to_destination(destination), performs: perform)
        }

        public static func rootNavigation(to destination: Parameter<BaseRouterNavigationDestination>, perform: @escaping (BaseRouterNavigationDestination) -> Void) -> Perform {
            Perform(method: .m_rootNavigation__to_destination(destination), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - MainVCProtocol

open class MainVCProtocolMock: MainVCProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var itemSelected: Observable<Int> { invocations.append(.p_itemSelected_get); return __p_itemSelected ?? givenGetterValue(.p_itemSelected_get, "MainVCProtocolMock - stub value for itemSelected was not defined") }

    private var __p_itemSelected: (Observable<Int>)?

    public var tapSearchButton: Driver<Void> { invocations.append(.p_tapSearchButton_get); return __p_tapSearchButton ?? givenGetterValue(.p_tapSearchButton_get, "MainVCProtocolMock - stub value for tapSearchButton was not defined") }

    private var __p_tapSearchButton: (Driver<Void>)?

    fileprivate enum MethodType {
        case p_itemSelected_get
        case p_tapSearchButton_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) { case (.p_itemSelected_get, .p_itemSelected_get): return Matcher.ComparisonResult.match
            case (.p_tapSearchButton_get, .p_tapSearchButton_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .p_itemSelected_get: return 0
            case .p_tapSearchButton_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .p_itemSelected_get: return "[get] .itemSelected"
            case .p_tapSearchButton_get: return "[get] .tapSearchButton"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func itemSelected(getter defaultValue: Observable<Int>...) -> PropertyStub {
            Given(method: .p_itemSelected_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func tapSearchButton(getter defaultValue: Driver<Void>...) -> PropertyStub {
            Given(method: .p_tapSearchButton_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static var itemSelected: Verify { Verify(method: .p_itemSelected_get) }
        public static var tapSearchButton: Verify { Verify(method: .p_tapSearchButton_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - MainViewModelProtocol

open class MainViewModelProtocolMock: MainViewModelProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var searchHistoryList: Driver<[SearchResultEntity]> { invocations.append(.p_searchHistoryList_get); return __p_searchHistoryList ?? givenGetterValue(.p_searchHistoryList_get, "MainViewModelProtocolMock - stub value for searchHistoryList was not defined") }

    private var __p_searchHistoryList: (Driver<[SearchResultEntity]>)?

    open func loadedViews() {
        addInvocation(.m_loadedViews)
        let perform = methodPerformValue(.m_loadedViews) as? () -> Void
        perform?()
    }

    open func viewWillApper() {
        addInvocation(.m_viewWillApper)
        let perform = methodPerformValue(.m_viewWillApper) as? () -> Void
        perform?()
    }

    fileprivate enum MethodType {
        case m_loadedViews
        case m_viewWillApper
        case p_searchHistoryList_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_loadedViews, .m_loadedViews): return .match

            case (.m_viewWillApper, .m_viewWillApper): return .match
            case (.p_searchHistoryList_get, .p_searchHistoryList_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_loadedViews: return 0
            case .m_viewWillApper: return 0
            case .p_searchHistoryList_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_loadedViews: return ".loadedViews()"
            case .m_viewWillApper: return ".viewWillApper()"
            case .p_searchHistoryList_get: return "[get] .searchHistoryList"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func searchHistoryList(getter defaultValue: Driver<[SearchResultEntity]>...) -> PropertyStub {
            Given(method: .p_searchHistoryList_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func loadedViews() -> Verify { Verify(method: .m_loadedViews) }
        public static func viewWillApper() -> Verify { Verify(method: .m_viewWillApper) }
        public static var searchHistoryList: Verify { Verify(method: .p_searchHistoryList_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func loadedViews(perform: @escaping () -> Void) -> Perform {
            Perform(method: .m_loadedViews, performs: perform)
        }

        public static func viewWillApper(perform: @escaping () -> Void) -> Perform {
            Perform(method: .m_viewWillApper, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - RecommendListRouterProtocol

open class RecommendListRouterProtocolMock: RecommendListRouterProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var window: UIWindow? { invocations.append(.p_window_get); return __p_window ?? optionalGivenGetterValue(.p_window_get, "RecommendListRouterProtocolMock - stub value for window was not defined") }

    private var __p_window: (UIWindow)?

    open func navigate(to destination: RecommendListNavigationDestination) {
        addInvocation(.m_navigate__to_destination(Parameter<RecommendListNavigationDestination>.value(destination)))
        let perform = methodPerformValue(.m_navigate__to_destination(Parameter<RecommendListNavigationDestination>.value(destination))) as? (RecommendListNavigationDestination) -> Void
        perform?(destination)
    }

    open func rootNavigation(to destination: BaseRouterNavigationDestination) {
        addInvocation(.m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>.value(destination)))
        let perform = methodPerformValue(.m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>.value(destination))) as? (BaseRouterNavigationDestination) -> Void
        perform?(destination)
    }

    fileprivate enum MethodType {
        case m_navigate__to_destination(Parameter<RecommendListNavigationDestination>)
        case m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>)
        case p_window_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_navigate__to_destination(lhsDestination), .m_navigate__to_destination(rhsDestination)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDestination, rhs: rhsDestination, with: matcher), lhsDestination, rhsDestination, "to destination"))
                return Matcher.ComparisonResult(results)

            case let (.m_rootNavigation__to_destination(lhsDestination), .m_rootNavigation__to_destination(rhsDestination)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDestination, rhs: rhsDestination, with: matcher), lhsDestination, rhsDestination, "to destination"))
                return Matcher.ComparisonResult(results)
            case (.p_window_get, .p_window_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_navigate__to_destination(p0): return p0.intValue
            case let .m_rootNavigation__to_destination(p0): return p0.intValue
            case .p_window_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_navigate__to_destination: return ".navigate(to:)"
            case .m_rootNavigation__to_destination: return ".rootNavigation(to:)"
            case .p_window_get: return "[get] .window"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func window(getter defaultValue: UIWindow?...) -> PropertyStub {
            Given(method: .p_window_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func navigate(to destination: Parameter<RecommendListNavigationDestination>) -> Verify { Verify(method: .m_navigate__to_destination(destination)) }
        public static func rootNavigation(to destination: Parameter<BaseRouterNavigationDestination>) -> Verify { Verify(method: .m_rootNavigation__to_destination(destination)) }
        public static var window: Verify { Verify(method: .p_window_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func navigate(to destination: Parameter<RecommendListNavigationDestination>, perform: @escaping (RecommendListNavigationDestination) -> Void) -> Perform {
            Perform(method: .m_navigate__to_destination(destination), performs: perform)
        }

        public static func rootNavigation(to destination: Parameter<BaseRouterNavigationDestination>, perform: @escaping (BaseRouterNavigationDestination) -> Void) -> Perform {
            Perform(method: .m_rootNavigation__to_destination(destination), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - RecommendListViewModelProtocol

open class RecommendListViewModelProtocolMock: RecommendListViewModelProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var categoryInfo: Driver<CategoryInfo> { invocations.append(.p_categoryInfo_get); return __p_categoryInfo ?? givenGetterValue(.p_categoryInfo_get, "RecommendListViewModelProtocolMock - stub value for categoryInfo was not defined") }

    private var __p_categoryInfo: (Driver<CategoryInfo>)?

    public var categoryList: Driver<[SpotCategory]> { invocations.append(.p_categoryList_get); return __p_categoryList ?? givenGetterValue(.p_categoryList_get, "RecommendListViewModelProtocolMock - stub value for categoryList was not defined") }

    private var __p_categoryList: (Driver<[SpotCategory]>)?

    public var spotEntityData: Driver<[SpotEntityData]> { invocations.append(.p_spotEntityData_get); return __p_spotEntityData ?? givenGetterValue(.p_spotEntityData_get, "RecommendListViewModelProtocolMock - stub value for spotEntityData was not defined") }

    private var __p_spotEntityData: (Driver<[SpotEntityData]>)?

    open func loadedViews() {
        addInvocation(.m_loadedViews)
        let perform = methodPerformValue(.m_loadedViews) as? () -> Void
        perform?()
    }

    fileprivate enum MethodType {
        case m_loadedViews
        case p_categoryInfo_get
        case p_categoryList_get
        case p_spotEntityData_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_loadedViews, .m_loadedViews): return .match
            case (.p_categoryInfo_get, .p_categoryInfo_get): return Matcher.ComparisonResult.match
            case (.p_categoryList_get, .p_categoryList_get): return Matcher.ComparisonResult.match
            case (.p_spotEntityData_get, .p_spotEntityData_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_loadedViews: return 0
            case .p_categoryInfo_get: return 0
            case .p_categoryList_get: return 0
            case .p_spotEntityData_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_loadedViews: return ".loadedViews()"
            case .p_categoryInfo_get: return "[get] .categoryInfo"
            case .p_categoryList_get: return "[get] .categoryList"
            case .p_spotEntityData_get: return "[get] .spotEntityData"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func categoryInfo(getter defaultValue: Driver<CategoryInfo>...) -> PropertyStub {
            Given(method: .p_categoryInfo_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func categoryList(getter defaultValue: Driver<[SpotCategory]>...) -> PropertyStub {
            Given(method: .p_categoryList_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func spotEntityData(getter defaultValue: Driver<[SpotEntityData]>...) -> PropertyStub {
            Given(method: .p_spotEntityData_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func loadedViews() -> Verify { Verify(method: .m_loadedViews) }
        public static var categoryInfo: Verify { Verify(method: .p_categoryInfo_get) }
        public static var categoryList: Verify { Verify(method: .p_categoryList_get) }
        public static var spotEntityData: Verify { Verify(method: .p_spotEntityData_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func loadedViews(perform: @escaping () -> Void) -> Perform {
            Perform(method: .m_loadedViews, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - ResasGatewayProtocol

open class ResasGatewayProtocolMock: ResasGatewayProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    open func getMunicipalities(prefCode: String) -> Single<ApiResponseEntity<ResasMunicipalityResponseEntity>> {
        addInvocation(.m_getMunicipalities__prefCode_prefCode(Parameter<String>.value(prefCode)))
        let perform = methodPerformValue(.m_getMunicipalities__prefCode_prefCode(Parameter<String>.value(prefCode))) as? (String) -> Void
        perform?(prefCode)
        var __value: Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>
        do {
            __value = try methodReturnValue(.m_getMunicipalities__prefCode_prefCode(Parameter<String>.value(prefCode))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getMunicipalities(prefCode: String). Use given")
            Failure("Stub return value not specified for getMunicipalities(prefCode: String). Use given")
        }
        return __value
    }

    fileprivate enum MethodType {
        case m_getMunicipalities__prefCode_prefCode(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_getMunicipalities__prefCode_prefCode(lhsPrefcode), .m_getMunicipalities__prefCode_prefCode(rhsPrefcode)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPrefcode, rhs: rhsPrefcode, with: matcher), lhsPrefcode, rhsPrefcode, "prefCode"))
                return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getMunicipalities__prefCode_prefCode(p0): return p0.intValue
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_getMunicipalities__prefCode_prefCode: return ".getMunicipalities(prefCode:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func getMunicipalities(prefCode: Parameter<String>, willReturn: Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>...) -> MethodStub {
            Given(method: .m_getMunicipalities__prefCode_prefCode(prefCode), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getMunicipalities(prefCode: Parameter<String>, willProduce: (Stubber<Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>>) -> Void) -> MethodStub {
            let willReturn: [Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>] = []
            let given: Given = { Given(method: .m_getMunicipalities__prefCode_prefCode(prefCode), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>.self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getMunicipalities(prefCode: Parameter<String>) -> Verify { Verify(method: .m_getMunicipalities__prefCode_prefCode(prefCode)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getMunicipalities(prefCode: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            Perform(method: .m_getMunicipalities__prefCode_prefCode(prefCode), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - ResasUseCaseProtocol

open class ResasUseCaseProtocolMock: ResasUseCaseProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    open func getCitiesInPrefecture(prefCode: String) -> Single<ApiResponseEntity<ResasMunicipalityResponseEntity>> {
        addInvocation(.m_getCitiesInPrefecture__prefCode_prefCode(Parameter<String>.value(prefCode)))
        let perform = methodPerformValue(.m_getCitiesInPrefecture__prefCode_prefCode(Parameter<String>.value(prefCode))) as? (String) -> Void
        perform?(prefCode)
        var __value: Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>
        do {
            __value = try methodReturnValue(.m_getCitiesInPrefecture__prefCode_prefCode(Parameter<String>.value(prefCode))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getCitiesInPrefecture(prefCode: String). Use given")
            Failure("Stub return value not specified for getCitiesInPrefecture(prefCode: String). Use given")
        }
        return __value
    }

    fileprivate enum MethodType {
        case m_getCitiesInPrefecture__prefCode_prefCode(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_getCitiesInPrefecture__prefCode_prefCode(lhsPrefcode), .m_getCitiesInPrefecture__prefCode_prefCode(rhsPrefcode)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPrefcode, rhs: rhsPrefcode, with: matcher), lhsPrefcode, rhsPrefcode, "prefCode"))
                return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getCitiesInPrefecture__prefCode_prefCode(p0): return p0.intValue
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_getCitiesInPrefecture__prefCode_prefCode: return ".getCitiesInPrefecture(prefCode:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func getCitiesInPrefecture(prefCode: Parameter<String>, willReturn: Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>...) -> MethodStub {
            Given(method: .m_getCitiesInPrefecture__prefCode_prefCode(prefCode), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getCitiesInPrefecture(prefCode: Parameter<String>, willProduce: (Stubber<Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>>) -> Void) -> MethodStub {
            let willReturn: [Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>] = []
            let given: Given = { Given(method: .m_getCitiesInPrefecture__prefCode_prefCode(prefCode), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<ApiResponseEntity<ResasMunicipalityResponseEntity>>.self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getCitiesInPrefecture(prefCode: Parameter<String>) -> Verify { Verify(method: .m_getCitiesInPrefecture__prefCode_prefCode(prefCode)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getCitiesInPrefecture(prefCode: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            Perform(method: .m_getCitiesInPrefecture__prefCode_prefCode(prefCode), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SearchConditionRouterProtocol

open class SearchConditionRouterProtocolMock: SearchConditionRouterProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var window: UIWindow? { invocations.append(.p_window_get); return __p_window ?? optionalGivenGetterValue(.p_window_get, "SearchConditionRouterProtocolMock - stub value for window was not defined") }

    private var __p_window: (UIWindow)?

    open func navigate(to destination: SearchConditionNavigationDestination) {
        addInvocation(.m_navigate__to_destination(Parameter<SearchConditionNavigationDestination>.value(destination)))
        let perform = methodPerformValue(.m_navigate__to_destination(Parameter<SearchConditionNavigationDestination>.value(destination))) as? (SearchConditionNavigationDestination) -> Void
        perform?(destination)
    }

    open func rootNavigation(to destination: BaseRouterNavigationDestination) {
        addInvocation(.m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>.value(destination)))
        let perform = methodPerformValue(.m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>.value(destination))) as? (BaseRouterNavigationDestination) -> Void
        perform?(destination)
    }

    fileprivate enum MethodType {
        case m_navigate__to_destination(Parameter<SearchConditionNavigationDestination>)
        case m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>)
        case p_window_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_navigate__to_destination(lhsDestination), .m_navigate__to_destination(rhsDestination)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDestination, rhs: rhsDestination, with: matcher), lhsDestination, rhsDestination, "to destination"))
                return Matcher.ComparisonResult(results)

            case let (.m_rootNavigation__to_destination(lhsDestination), .m_rootNavigation__to_destination(rhsDestination)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDestination, rhs: rhsDestination, with: matcher), lhsDestination, rhsDestination, "to destination"))
                return Matcher.ComparisonResult(results)
            case (.p_window_get, .p_window_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_navigate__to_destination(p0): return p0.intValue
            case let .m_rootNavigation__to_destination(p0): return p0.intValue
            case .p_window_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_navigate__to_destination: return ".navigate(to:)"
            case .m_rootNavigation__to_destination: return ".rootNavigation(to:)"
            case .p_window_get: return "[get] .window"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func window(getter defaultValue: UIWindow?...) -> PropertyStub {
            Given(method: .p_window_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func navigate(to destination: Parameter<SearchConditionNavigationDestination>) -> Verify { Verify(method: .m_navigate__to_destination(destination)) }
        public static func rootNavigation(to destination: Parameter<BaseRouterNavigationDestination>) -> Verify { Verify(method: .m_rootNavigation__to_destination(destination)) }
        public static var window: Verify { Verify(method: .p_window_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func navigate(to destination: Parameter<SearchConditionNavigationDestination>, perform: @escaping (SearchConditionNavigationDestination) -> Void) -> Perform {
            Perform(method: .m_navigate__to_destination(destination), performs: perform)
        }

        public static func rootNavigation(to destination: Parameter<BaseRouterNavigationDestination>, perform: @escaping (BaseRouterNavigationDestination) -> Void) -> Perform {
            Perform(method: .m_rootNavigation__to_destination(destination), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SearchConditionVCProtocol

open class SearchConditionVCProtocolMock: SearchConditionVCProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var tapBackButton: Signal<Void> { invocations.append(.p_tapBackButton_get); return __p_tapBackButton ?? givenGetterValue(.p_tapBackButton_get, "SearchConditionVCProtocolMock - stub value for tapBackButton was not defined") }

    private var __p_tapBackButton: (Signal<Void>)?

    public var tapSearchButton: Signal<Void> { invocations.append(.p_tapSearchButton_get); return __p_tapSearchButton ?? givenGetterValue(.p_tapSearchButton_get, "SearchConditionVCProtocolMock - stub value for tapSearchButton was not defined") }

    private var __p_tapSearchButton: (Signal<Void>)?

    public var selectedSearchCondition: Driver<Int> { invocations.append(.p_selectedSearchCondition_get); return __p_selectedSearchCondition ?? givenGetterValue(.p_selectedSearchCondition_get, "SearchConditionVCProtocolMock - stub value for selectedSearchCondition was not defined") }

    private var __p_selectedSearchCondition: (Driver<Int>)?

    public var areaSelectedIndex: Driver<Int> { invocations.append(.p_areaSelectedIndex_get); return __p_areaSelectedIndex ?? givenGetterValue(.p_areaSelectedIndex_get, "SearchConditionVCProtocolMock - stub value for areaSelectedIndex was not defined") }

    private var __p_areaSelectedIndex: (Driver<Int>)?

    public var prefectureSelectedIndex: Driver<Int> { invocations.append(.p_prefectureSelectedIndex_get); return __p_prefectureSelectedIndex ?? givenGetterValue(.p_prefectureSelectedIndex_get, "SearchConditionVCProtocolMock - stub value for prefectureSelectedIndex was not defined") }

    private var __p_prefectureSelectedIndex: (Driver<Int>)?

    public var selectedLocation: Driver<(lat: Double, lng: Double)> { invocations.append(.p_selectedLocation_get); return __p_selectedLocation ?? givenGetterValue(.p_selectedLocation_get, "SearchConditionVCProtocolMock - stub value for selectedLocation was not defined") }

    private var __p_selectedLocation: (Driver<(lat: Double, lng: Double)>)?

    public var selectedRadius: Driver<Float> { invocations.append(.p_selectedRadius_get); return __p_selectedRadius ?? givenGetterValue(.p_selectedRadius_get, "SearchConditionVCProtocolMock - stub value for selectedRadius was not defined") }

    private var __p_selectedRadius: (Driver<Float>)?

    fileprivate enum MethodType {
        case p_tapBackButton_get
        case p_tapSearchButton_get
        case p_selectedSearchCondition_get
        case p_areaSelectedIndex_get
        case p_prefectureSelectedIndex_get
        case p_selectedLocation_get
        case p_selectedRadius_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) { case (.p_tapBackButton_get, .p_tapBackButton_get): return Matcher.ComparisonResult.match
            case (.p_tapSearchButton_get, .p_tapSearchButton_get): return Matcher.ComparisonResult.match
            case (.p_selectedSearchCondition_get, .p_selectedSearchCondition_get): return Matcher.ComparisonResult.match
            case (.p_areaSelectedIndex_get, .p_areaSelectedIndex_get): return Matcher.ComparisonResult.match
            case (.p_prefectureSelectedIndex_get, .p_prefectureSelectedIndex_get): return Matcher.ComparisonResult.match
            case (.p_selectedLocation_get, .p_selectedLocation_get): return Matcher.ComparisonResult.match
            case (.p_selectedRadius_get, .p_selectedRadius_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .p_tapBackButton_get: return 0
            case .p_tapSearchButton_get: return 0
            case .p_selectedSearchCondition_get: return 0
            case .p_areaSelectedIndex_get: return 0
            case .p_prefectureSelectedIndex_get: return 0
            case .p_selectedLocation_get: return 0
            case .p_selectedRadius_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .p_tapBackButton_get: return "[get] .tapBackButton"
            case .p_tapSearchButton_get: return "[get] .tapSearchButton"
            case .p_selectedSearchCondition_get: return "[get] .selectedSearchCondition"
            case .p_areaSelectedIndex_get: return "[get] .areaSelectedIndex"
            case .p_prefectureSelectedIndex_get: return "[get] .prefectureSelectedIndex"
            case .p_selectedLocation_get: return "[get] .selectedLocation"
            case .p_selectedRadius_get: return "[get] .selectedRadius"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func tapBackButton(getter defaultValue: Signal<Void>...) -> PropertyStub {
            Given(method: .p_tapBackButton_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func tapSearchButton(getter defaultValue: Signal<Void>...) -> PropertyStub {
            Given(method: .p_tapSearchButton_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func selectedSearchCondition(getter defaultValue: Driver<Int>...) -> PropertyStub {
            Given(method: .p_selectedSearchCondition_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func areaSelectedIndex(getter defaultValue: Driver<Int>...) -> PropertyStub {
            Given(method: .p_areaSelectedIndex_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func prefectureSelectedIndex(getter defaultValue: Driver<Int>...) -> PropertyStub {
            Given(method: .p_prefectureSelectedIndex_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func selectedLocation(getter defaultValue: Driver<(lat: Double, lng: Double)>...) -> PropertyStub {
            Given(method: .p_selectedLocation_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func selectedRadius(getter defaultValue: Driver<Float>...) -> PropertyStub {
            Given(method: .p_selectedRadius_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static var tapBackButton: Verify { Verify(method: .p_tapBackButton_get) }
        public static var tapSearchButton: Verify { Verify(method: .p_tapSearchButton_get) }
        public static var selectedSearchCondition: Verify { Verify(method: .p_selectedSearchCondition_get) }
        public static var areaSelectedIndex: Verify { Verify(method: .p_areaSelectedIndex_get) }
        public static var prefectureSelectedIndex: Verify { Verify(method: .p_prefectureSelectedIndex_get) }
        public static var selectedLocation: Verify { Verify(method: .p_selectedLocation_get) }
        public static var selectedRadius: Verify { Verify(method: .p_selectedRadius_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SearchConditionViewModelProtocol

open class SearchConditionViewModelProtocolMock: SearchConditionViewModelProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var searchConditionTypeList: Driver<[SearchConditionData]> { invocations.append(.p_searchConditionTypeList_get); return __p_searchConditionTypeList ?? givenGetterValue(.p_searchConditionTypeList_get, "SearchConditionViewModelProtocolMock - stub value for searchConditionTypeList was not defined") }

    private var __p_searchConditionTypeList: (Driver<[SearchConditionData]>)?

    public var selectedSearchConditionType: Driver<SearchConditionType> { invocations.append(.p_selectedSearchConditionType_get); return __p_selectedSearchConditionType ?? givenGetterValue(.p_selectedSearchConditionType_get, "SearchConditionViewModelProtocolMock - stub value for selectedSearchConditionType was not defined") }

    private var __p_selectedSearchConditionType: (Driver<SearchConditionType>)?

    public var searchConditionPrefectures: Driver<SearchConditionPrefectures> { invocations.append(.p_searchConditionPrefectures_get); return __p_searchConditionPrefectures ?? givenGetterValue(.p_searchConditionPrefectures_get, "SearchConditionViewModelProtocolMock - stub value for searchConditionPrefectures was not defined") }

    private var __p_searchConditionPrefectures: (Driver<SearchConditionPrefectures>)?

    public var searchConditionCurrentLocation: Driver<SearchConditionCurrentLocation> { invocations.append(.p_searchConditionCurrentLocation_get); return __p_searchConditionCurrentLocation ?? givenGetterValue(.p_searchConditionCurrentLocation_get, "SearchConditionViewModelProtocolMock - stub value for searchConditionCurrentLocation was not defined") }

    private var __p_searchConditionCurrentLocation: (Driver<SearchConditionCurrentLocation>)?

    public var currentLocation: Driver<(lat: Double, lng: Double)> { invocations.append(.p_currentLocation_get); return __p_currentLocation ?? givenGetterValue(.p_currentLocation_get, "SearchConditionViewModelProtocolMock - stub value for currentLocation was not defined") }

    private var __p_currentLocation: (Driver<(lat: Double, lng: Double)>)?

    public var searchPermission: Driver<Bool> { invocations.append(.p_searchPermission_get); return __p_searchPermission ?? givenGetterValue(.p_searchPermission_get, "SearchConditionViewModelProtocolMock - stub value for searchPermission was not defined") }

    private var __p_searchPermission: (Driver<Bool>)?

    open func loadedViews() {
        addInvocation(.m_loadedViews)
        let perform = methodPerformValue(.m_loadedViews) as? () -> Void
        perform?()
    }

    fileprivate enum MethodType {
        case m_loadedViews
        case p_searchConditionTypeList_get
        case p_selectedSearchConditionType_get
        case p_searchConditionPrefectures_get
        case p_searchConditionCurrentLocation_get
        case p_currentLocation_get
        case p_searchPermission_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_loadedViews, .m_loadedViews): return .match
            case (.p_searchConditionTypeList_get, .p_searchConditionTypeList_get): return Matcher.ComparisonResult.match
            case (.p_selectedSearchConditionType_get, .p_selectedSearchConditionType_get): return Matcher.ComparisonResult.match
            case (.p_searchConditionPrefectures_get, .p_searchConditionPrefectures_get): return Matcher.ComparisonResult.match
            case (.p_searchConditionCurrentLocation_get, .p_searchConditionCurrentLocation_get): return Matcher.ComparisonResult.match
            case (.p_currentLocation_get, .p_currentLocation_get): return Matcher.ComparisonResult.match
            case (.p_searchPermission_get, .p_searchPermission_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_loadedViews: return 0
            case .p_searchConditionTypeList_get: return 0
            case .p_selectedSearchConditionType_get: return 0
            case .p_searchConditionPrefectures_get: return 0
            case .p_searchConditionCurrentLocation_get: return 0
            case .p_currentLocation_get: return 0
            case .p_searchPermission_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_loadedViews: return ".loadedViews()"
            case .p_searchConditionTypeList_get: return "[get] .searchConditionTypeList"
            case .p_selectedSearchConditionType_get: return "[get] .selectedSearchConditionType"
            case .p_searchConditionPrefectures_get: return "[get] .searchConditionPrefectures"
            case .p_searchConditionCurrentLocation_get: return "[get] .searchConditionCurrentLocation"
            case .p_currentLocation_get: return "[get] .currentLocation"
            case .p_searchPermission_get: return "[get] .searchPermission"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func searchConditionTypeList(getter defaultValue: Driver<[SearchConditionData]>...) -> PropertyStub {
            Given(method: .p_searchConditionTypeList_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func selectedSearchConditionType(getter defaultValue: Driver<SearchConditionType>...) -> PropertyStub {
            Given(method: .p_selectedSearchConditionType_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func searchConditionPrefectures(getter defaultValue: Driver<SearchConditionPrefectures>...) -> PropertyStub {
            Given(method: .p_searchConditionPrefectures_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func searchConditionCurrentLocation(getter defaultValue: Driver<SearchConditionCurrentLocation>...) -> PropertyStub {
            Given(method: .p_searchConditionCurrentLocation_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func currentLocation(getter defaultValue: Driver<(lat: Double, lng: Double)>...) -> PropertyStub {
            Given(method: .p_currentLocation_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func searchPermission(getter defaultValue: Driver<Bool>...) -> PropertyStub {
            Given(method: .p_searchPermission_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func loadedViews() -> Verify { Verify(method: .m_loadedViews) }
        public static var searchConditionTypeList: Verify { Verify(method: .p_searchConditionTypeList_get) }
        public static var selectedSearchConditionType: Verify { Verify(method: .p_selectedSearchConditionType_get) }
        public static var searchConditionPrefectures: Verify { Verify(method: .p_searchConditionPrefectures_get) }
        public static var searchConditionCurrentLocation: Verify { Verify(method: .p_searchConditionCurrentLocation_get) }
        public static var currentLocation: Verify { Verify(method: .p_currentLocation_get) }
        public static var searchPermission: Verify { Verify(method: .p_searchPermission_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func loadedViews(perform: @escaping () -> Void) -> Perform {
            Perform(method: .m_loadedViews, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SearchLoadingRouterProtocol

open class SearchLoadingRouterProtocolMock: SearchLoadingRouterProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var window: UIWindow? { invocations.append(.p_window_get); return __p_window ?? optionalGivenGetterValue(.p_window_get, "SearchLoadingRouterProtocolMock - stub value for window was not defined") }

    private var __p_window: (UIWindow)?

    open func navigate(to destination: SearchLoadingNavigationDestination) {
        addInvocation(.m_navigate__to_destination(Parameter<SearchLoadingNavigationDestination>.value(destination)))
        let perform = methodPerformValue(.m_navigate__to_destination(Parameter<SearchLoadingNavigationDestination>.value(destination))) as? (SearchLoadingNavigationDestination) -> Void
        perform?(destination)
    }

    open func rootNavigation(to destination: BaseRouterNavigationDestination) {
        addInvocation(.m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>.value(destination)))
        let perform = methodPerformValue(.m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>.value(destination))) as? (BaseRouterNavigationDestination) -> Void
        perform?(destination)
    }

    fileprivate enum MethodType {
        case m_navigate__to_destination(Parameter<SearchLoadingNavigationDestination>)
        case m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>)
        case p_window_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_navigate__to_destination(lhsDestination), .m_navigate__to_destination(rhsDestination)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDestination, rhs: rhsDestination, with: matcher), lhsDestination, rhsDestination, "to destination"))
                return Matcher.ComparisonResult(results)

            case let (.m_rootNavigation__to_destination(lhsDestination), .m_rootNavigation__to_destination(rhsDestination)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDestination, rhs: rhsDestination, with: matcher), lhsDestination, rhsDestination, "to destination"))
                return Matcher.ComparisonResult(results)
            case (.p_window_get, .p_window_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_navigate__to_destination(p0): return p0.intValue
            case let .m_rootNavigation__to_destination(p0): return p0.intValue
            case .p_window_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_navigate__to_destination: return ".navigate(to:)"
            case .m_rootNavigation__to_destination: return ".rootNavigation(to:)"
            case .p_window_get: return "[get] .window"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func window(getter defaultValue: UIWindow?...) -> PropertyStub {
            Given(method: .p_window_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func navigate(to destination: Parameter<SearchLoadingNavigationDestination>) -> Verify { Verify(method: .m_navigate__to_destination(destination)) }
        public static func rootNavigation(to destination: Parameter<BaseRouterNavigationDestination>) -> Verify { Verify(method: .m_rootNavigation__to_destination(destination)) }
        public static var window: Verify { Verify(method: .p_window_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func navigate(to destination: Parameter<SearchLoadingNavigationDestination>, perform: @escaping (SearchLoadingNavigationDestination) -> Void) -> Perform {
            Perform(method: .m_navigate__to_destination(destination), performs: perform)
        }

        public static func rootNavigation(to destination: Parameter<BaseRouterNavigationDestination>, perform: @escaping (BaseRouterNavigationDestination) -> Void) -> Perform {
            Perform(method: .m_rootNavigation__to_destination(destination), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SearchLoadingVCProtocol

open class SearchLoadingVCProtocolMock: SearchLoadingVCProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var completionAnmation: Signal<Bool> { invocations.append(.p_completionAnmation_get); return __p_completionAnmation ?? givenGetterValue(.p_completionAnmation_get, "SearchLoadingVCProtocolMock - stub value for completionAnmation was not defined") }

    private var __p_completionAnmation: (Signal<Bool>)?

    fileprivate enum MethodType {
        case p_completionAnmation_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) { case (.p_completionAnmation_get, .p_completionAnmation_get): return Matcher.ComparisonResult.match
            }
        }

        func intValue() -> Int {
            switch self {
            case .p_completionAnmation_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .p_completionAnmation_get: return "[get] .completionAnmation"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func completionAnmation(getter defaultValue: Signal<Bool>...) -> PropertyStub {
            Given(method: .p_completionAnmation_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static var completionAnmation: Verify { Verify(method: .p_completionAnmation_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SearchLoadingViewModelProtocol

open class SearchLoadingViewModelProtocolMock: SearchLoadingViewModelProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var loadingState: Driver<LoadingState> { invocations.append(.p_loadingState_get); return __p_loadingState ?? givenGetterValue(.p_loadingState_get, "SearchLoadingViewModelProtocolMock - stub value for loadingState was not defined") }

    private var __p_loadingState: (Driver<LoadingState>)?

    open func loadedViews() {
        addInvocation(.m_loadedViews)
        let perform = methodPerformValue(.m_loadedViews) as? () -> Void
        perform?()
    }

    fileprivate enum MethodType {
        case m_loadedViews
        case p_loadingState_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_loadedViews, .m_loadedViews): return .match
            case (.p_loadingState_get, .p_loadingState_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_loadedViews: return 0
            case .p_loadingState_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_loadedViews: return ".loadedViews()"
            case .p_loadingState_get: return "[get] .loadingState"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func loadingState(getter defaultValue: Driver<LoadingState>...) -> PropertyStub {
            Given(method: .p_loadingState_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func loadedViews() -> Verify { Verify(method: .m_loadedViews) }
        public static var loadingState: Verify { Verify(method: .p_loadingState_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func loadedViews(perform: @escaping () -> Void) -> Perform {
            Perform(method: .m_loadedViews, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SearchResultRouterProtocol

open class SearchResultRouterProtocolMock: SearchResultRouterProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var window: UIWindow? { invocations.append(.p_window_get); return __p_window ?? optionalGivenGetterValue(.p_window_get, "SearchResultRouterProtocolMock - stub value for window was not defined") }

    private var __p_window: (UIWindow)?

    open func navigate(to destination: SearchResultNavigationDestination) {
        addInvocation(.m_navigate__to_destination(Parameter<SearchResultNavigationDestination>.value(destination)))
        let perform = methodPerformValue(.m_navigate__to_destination(Parameter<SearchResultNavigationDestination>.value(destination))) as? (SearchResultNavigationDestination) -> Void
        perform?(destination)
    }

    open func rootNavigation(to destination: BaseRouterNavigationDestination) {
        addInvocation(.m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>.value(destination)))
        let perform = methodPerformValue(.m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>.value(destination))) as? (BaseRouterNavigationDestination) -> Void
        perform?(destination)
    }

    fileprivate enum MethodType {
        case m_navigate__to_destination(Parameter<SearchResultNavigationDestination>)
        case m_rootNavigation__to_destination(Parameter<BaseRouterNavigationDestination>)
        case p_window_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_navigate__to_destination(lhsDestination), .m_navigate__to_destination(rhsDestination)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDestination, rhs: rhsDestination, with: matcher), lhsDestination, rhsDestination, "to destination"))
                return Matcher.ComparisonResult(results)

            case let (.m_rootNavigation__to_destination(lhsDestination), .m_rootNavigation__to_destination(rhsDestination)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDestination, rhs: rhsDestination, with: matcher), lhsDestination, rhsDestination, "to destination"))
                return Matcher.ComparisonResult(results)
            case (.p_window_get, .p_window_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_navigate__to_destination(p0): return p0.intValue
            case let .m_rootNavigation__to_destination(p0): return p0.intValue
            case .p_window_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_navigate__to_destination: return ".navigate(to:)"
            case .m_rootNavigation__to_destination: return ".rootNavigation(to:)"
            case .p_window_get: return "[get] .window"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func window(getter defaultValue: UIWindow?...) -> PropertyStub {
            Given(method: .p_window_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func navigate(to destination: Parameter<SearchResultNavigationDestination>) -> Verify { Verify(method: .m_navigate__to_destination(destination)) }
        public static func rootNavigation(to destination: Parameter<BaseRouterNavigationDestination>) -> Verify { Verify(method: .m_rootNavigation__to_destination(destination)) }
        public static var window: Verify { Verify(method: .p_window_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func navigate(to destination: Parameter<SearchResultNavigationDestination>, perform: @escaping (SearchResultNavigationDestination) -> Void) -> Perform {
            Perform(method: .m_navigate__to_destination(destination), performs: perform)
        }

        public static func rootNavigation(to destination: Parameter<BaseRouterNavigationDestination>, perform: @escaping (BaseRouterNavigationDestination) -> Void) -> Perform {
            Perform(method: .m_rootNavigation__to_destination(destination), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SearchResultUseCaseProtocol

open class SearchResultUseCaseProtocolMock: SearchResultUseCaseProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    open func getCitySearchResult() -> Single<Result<[SearchResultEntity], DataBaseError>> {
        addInvocation(.m_getCitySearchResult)
        let perform = methodPerformValue(.m_getCitySearchResult) as? () -> Void
        perform?()
        var __value: Single<Result<[SearchResultEntity], DataBaseError>>
        do {
            __value = try methodReturnValue(.m_getCitySearchResult).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getCitySearchResult(). Use given")
            Failure("Stub return value not specified for getCitySearchResult(). Use given")
        }
        return __value
    }

    open func saveCitySearchResult(prefCode: Int, cityName: String, cityCode: String?, lat: Double?, lng: Double?) -> Single<Result<SearchResultEntity, DataBaseError>> {
        addInvocation(.m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(Parameter<Int>.value(prefCode), Parameter<String>.value(cityName), Parameter<String?>.value(cityCode), Parameter<Double?>.value(lat), Parameter<Double?>.value(lng)))
        let perform = methodPerformValue(.m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(Parameter<Int>.value(prefCode), Parameter<String>.value(cityName), Parameter<String?>.value(cityCode), Parameter<Double?>.value(lat), Parameter<Double?>.value(lng))) as? (Int, String, String?, Double?, Double?) -> Void
        perform?(prefCode, cityName, cityCode, lat, lng)
        var __value: Single<Result<SearchResultEntity, DataBaseError>>
        do {
            __value = try methodReturnValue(.m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(Parameter<Int>.value(prefCode), Parameter<String>.value(cityName), Parameter<String?>.value(cityCode), Parameter<Double?>.value(lat), Parameter<Double?>.value(lng))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for saveCitySearchResult(prefCode: Int, cityName: String, cityCode: String?, lat: Double?, lng: Double?). Use given")
            Failure("Stub return value not specified for saveCitySearchResult(prefCode: Int, cityName: String, cityCode: String?, lat: Double?, lng: Double?). Use given")
        }
        return __value
    }

    fileprivate enum MethodType {
        case m_getCitySearchResult
        case m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(Parameter<Int>, Parameter<String>, Parameter<String?>, Parameter<Double?>, Parameter<Double?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getCitySearchResult, .m_getCitySearchResult): return .match

            case let (.m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(lhsPrefcode, lhsCityname, lhsCitycode, lhsLat, lhsLng), .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(rhsPrefcode, rhsCityname, rhsCitycode, rhsLat, rhsLng)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPrefcode, rhs: rhsPrefcode, with: matcher), lhsPrefcode, rhsPrefcode, "prefCode"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCityname, rhs: rhsCityname, with: matcher), lhsCityname, rhsCityname, "cityName"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCitycode, rhs: rhsCitycode, with: matcher), lhsCitycode, rhsCitycode, "cityCode"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLat, rhs: rhsLat, with: matcher), lhsLat, rhsLat, "lat"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLng, rhs: rhsLng, with: matcher), lhsLng, rhsLng, "lng"))
                return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getCitySearchResult: return 0
            case let .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(p0, p1, p2, p3, p4): return p0.intValue + p1.intValue + p2.intValue + p3.intValue + p4.intValue
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_getCitySearchResult: return ".getCitySearchResult()"
            case .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng: return ".saveCitySearchResult(prefCode:cityName:cityCode:lat:lng:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func getCitySearchResult(willReturn: Single<Result<[SearchResultEntity], DataBaseError>>...) -> MethodStub {
            Given(method: .m_getCitySearchResult, products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func saveCitySearchResult(prefCode: Parameter<Int>, cityName: Parameter<String>, cityCode: Parameter<String?>, lat: Parameter<Double?>, lng: Parameter<Double?>, willReturn: Single<Result<SearchResultEntity, DataBaseError>>...) -> MethodStub {
            Given(method: .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(prefCode, cityName, cityCode, lat, lng), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getCitySearchResult(willProduce: (Stubber<Single<Result<[SearchResultEntity], DataBaseError>>>) -> Void) -> MethodStub {
            let willReturn: [Single<Result<[SearchResultEntity], DataBaseError>>] = []
            let given: Given = { Given(method: .m_getCitySearchResult, products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<Result<[SearchResultEntity], DataBaseError>>.self)
            willProduce(stubber)
            return given
        }

        public static func saveCitySearchResult(prefCode: Parameter<Int>, cityName: Parameter<String>, cityCode: Parameter<String?>, lat: Parameter<Double?>, lng: Parameter<Double?>, willProduce: (Stubber<Single<Result<SearchResultEntity, DataBaseError>>>) -> Void) -> MethodStub {
            let willReturn: [Single<Result<SearchResultEntity, DataBaseError>>] = []
            let given: Given = { Given(method: .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(prefCode, cityName, cityCode, lat, lng), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<Result<SearchResultEntity, DataBaseError>>.self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getCitySearchResult() -> Verify { Verify(method: .m_getCitySearchResult) }
        public static func saveCitySearchResult(prefCode: Parameter<Int>, cityName: Parameter<String>, cityCode: Parameter<String?>, lat: Parameter<Double?>, lng: Parameter<Double?>) -> Verify { Verify(method: .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(prefCode, cityName, cityCode, lat, lng)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getCitySearchResult(perform: @escaping () -> Void) -> Perform {
            Perform(method: .m_getCitySearchResult, performs: perform)
        }

        public static func saveCitySearchResult(prefCode: Parameter<Int>, cityName: Parameter<String>, cityCode: Parameter<String?>, lat: Parameter<Double?>, lng: Parameter<Double?>, perform: @escaping (Int, String, String?, Double?, Double?) -> Void) -> Perform {
            Perform(method: .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamecityCode_cityCodelat_latlng_lng(prefCode, cityName, cityCode, lat, lng), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SearchResultVCProtocol

open class SearchResultVCProtocolMock: SearchResultVCProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var tapCloseButton: Driver<Void> { invocations.append(.p_tapCloseButton_get); return __p_tapCloseButton ?? givenGetterValue(.p_tapCloseButton_get, "SearchResultVCProtocolMock - stub value for tapCloseButton was not defined") }

    private var __p_tapCloseButton: (Driver<Void>)?

    public var tapMapButton: Driver<Void> { invocations.append(.p_tapMapButton_get); return __p_tapMapButton ?? givenGetterValue(.p_tapMapButton_get, "SearchResultVCProtocolMock - stub value for tapMapButton was not defined") }

    private var __p_tapMapButton: (Driver<Void>)?

    public var tapWebSearchButton: Driver<Void> { invocations.append(.p_tapWebSearchButton_get); return __p_tapWebSearchButton ?? givenGetterValue(.p_tapWebSearchButton_get, "SearchResultVCProtocolMock - stub value for tapWebSearchButton was not defined") }

    private var __p_tapWebSearchButton: (Driver<Void>)?

    public var tapRecommendButton: Driver<Void> { invocations.append(.p_tapRecommendButton_get); return __p_tapRecommendButton ?? givenGetterValue(.p_tapRecommendButton_get, "SearchResultVCProtocolMock - stub value for tapRecommendButton was not defined") }

    private var __p_tapRecommendButton: (Driver<Void>)?

    fileprivate enum MethodType {
        case p_tapCloseButton_get
        case p_tapMapButton_get
        case p_tapWebSearchButton_get
        case p_tapRecommendButton_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) { case (.p_tapCloseButton_get, .p_tapCloseButton_get): return Matcher.ComparisonResult.match
            case (.p_tapMapButton_get, .p_tapMapButton_get): return Matcher.ComparisonResult.match
            case (.p_tapWebSearchButton_get, .p_tapWebSearchButton_get): return Matcher.ComparisonResult.match
            case (.p_tapRecommendButton_get, .p_tapRecommendButton_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .p_tapCloseButton_get: return 0
            case .p_tapMapButton_get: return 0
            case .p_tapWebSearchButton_get: return 0
            case .p_tapRecommendButton_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .p_tapCloseButton_get: return "[get] .tapCloseButton"
            case .p_tapMapButton_get: return "[get] .tapMapButton"
            case .p_tapWebSearchButton_get: return "[get] .tapWebSearchButton"
            case .p_tapRecommendButton_get: return "[get] .tapRecommendButton"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func tapCloseButton(getter defaultValue: Driver<Void>...) -> PropertyStub {
            Given(method: .p_tapCloseButton_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func tapMapButton(getter defaultValue: Driver<Void>...) -> PropertyStub {
            Given(method: .p_tapMapButton_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func tapWebSearchButton(getter defaultValue: Driver<Void>...) -> PropertyStub {
            Given(method: .p_tapWebSearchButton_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }

        public static func tapRecommendButton(getter defaultValue: Driver<Void>...) -> PropertyStub {
            Given(method: .p_tapRecommendButton_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static var tapCloseButton: Verify { Verify(method: .p_tapCloseButton_get) }
        public static var tapMapButton: Verify { Verify(method: .p_tapMapButton_get) }
        public static var tapWebSearchButton: Verify { Verify(method: .p_tapWebSearchButton_get) }
        public static var tapRecommendButton: Verify { Verify(method: .p_tapRecommendButton_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SearchResultViewModelProtocol

open class SearchResultViewModelProtocolMock: SearchResultViewModelProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var animationData: Driver<(isAnimation: Bool, cityName: String)> { invocations.append(.p_animationData_get); return __p_animationData ?? givenGetterValue(.p_animationData_get, "SearchResultViewModelProtocolMock - stub value for animationData was not defined") }

    private var __p_animationData: (Driver<(isAnimation: Bool, cityName: String)>)?

    open func loadedViews() {
        addInvocation(.m_loadedViews)
        let perform = methodPerformValue(.m_loadedViews) as? () -> Void
        perform?()
    }

    fileprivate enum MethodType {
        case m_loadedViews
        case p_animationData_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_loadedViews, .m_loadedViews): return .match
            case (.p_animationData_get, .p_animationData_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_loadedViews: return 0
            case .p_animationData_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_loadedViews: return ".loadedViews()"
            case .p_animationData_get: return "[get] .animationData"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func animationData(getter defaultValue: Driver<(isAnimation: Bool, cityName: String)>...) -> PropertyStub {
            Given(method: .p_animationData_get, products: defaultValue.map { StubProduct.return($0 as Any) })
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func loadedViews() -> Verify { Verify(method: .m_loadedViews) }
        public static var animationData: Verify { Verify(method: .p_animationData_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func loadedViews(perform: @escaping () -> Void) -> Perform {
            Perform(method: .m_loadedViews, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - SpotSearchUseCaseProtocol

open class SpotSearchUseCaseProtocolMock: SpotSearchUseCaseProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    open func getSpot(
        cityCode: String,
        startIndex: Int,
        category: SpotCategory
    ) -> Single<ApiResponseEntity<[RecommendSpotEntity]>> {
        addInvocation(.m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(Parameter<String>.value(cityCode), Parameter<Int>.value(startIndex), Parameter<SpotCategory>.value(category)))
        let perform = methodPerformValue(.m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(Parameter<String>.value(cityCode), Parameter<Int>.value(startIndex), Parameter<SpotCategory>.value(category))) as? (String, Int, SpotCategory) -> Void
        perform?(cityCode, startIndex, category)
        var __value: Single<ApiResponseEntity<[RecommendSpotEntity]>>
        do {
            __value = try methodReturnValue(.m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(Parameter<String>.value(cityCode), Parameter<Int>.value(startIndex), Parameter<SpotCategory>.value(category))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getSpot(cityCode: String, startIndex: Int, category: SpotCategory). Use given")
            Failure("Stub return value not specified for getSpot(cityCode: String, startIndex: Int, category: SpotCategory). Use given")
        }
        return __value
    }

    open func getSpot(
        lat: Double,
        lng: Double,
        startIndex: Int,
        category: SpotCategory
    ) -> Single<ApiResponseEntity<[RecommendSpotEntity]>> {
        addInvocation(.m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Int>.value(startIndex), Parameter<SpotCategory>.value(category)))
        let perform = methodPerformValue(.m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Int>.value(startIndex), Parameter<SpotCategory>.value(category))) as? (Double, Double, Int, SpotCategory) -> Void
        perform?(lat, lng, startIndex, category)
        var __value: Single<ApiResponseEntity<[RecommendSpotEntity]>>
        do {
            __value = try methodReturnValue(.m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(Parameter<Double>.value(lat), Parameter<Double>.value(lng), Parameter<Int>.value(startIndex), Parameter<SpotCategory>.value(category))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getSpot(lat: Double, lng: Double, startIndex: Int, category: SpotCategory). Use given")
            Failure("Stub return value not specified for getSpot(lat: Double, lng: Double, startIndex: Int, category: SpotCategory). Use given")
        }
        return __value
    }

    fileprivate enum MethodType {
        case m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(Parameter<String>, Parameter<Int>, Parameter<SpotCategory>)
        case m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(Parameter<Double>, Parameter<Double>, Parameter<Int>, Parameter<SpotCategory>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(lhsCitycode, lhsStartindex, lhsCategory), .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(rhsCitycode, rhsStartindex, rhsCategory)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCitycode, rhs: rhsCitycode, with: matcher), lhsCitycode, rhsCitycode, "cityCode"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsStartindex, rhs: rhsStartindex, with: matcher), lhsStartindex, rhsStartindex, "startIndex"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCategory, rhs: rhsCategory, with: matcher), lhsCategory, rhsCategory, "category"))
                return Matcher.ComparisonResult(results)

            case let (.m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lhsLat, lhsLng, lhsStartindex, lhsCategory), .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(rhsLat, rhsLng, rhsStartindex, rhsCategory)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLat, rhs: rhsLat, with: matcher), lhsLat, rhsLat, "lat"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLng, rhs: rhsLng, with: matcher), lhsLng, rhsLng, "lng"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsStartindex, rhs: rhsStartindex, with: matcher), lhsStartindex, rhsStartindex, "startIndex"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCategory, rhs: rhsCategory, with: matcher), lhsCategory, rhsCategory, "category"))
                return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category: return ".getSpot(cityCode:startIndex:category:)"
            case .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category: return ".getSpot(lat:lng:startIndex:category:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func getSpot(cityCode: Parameter<String>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>, willReturn: Single<ApiResponseEntity<[RecommendSpotEntity]>>...) -> MethodStub {
            Given(method: .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(cityCode, startIndex, category), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getSpot(lat: Parameter<Double>, lng: Parameter<Double>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>, willReturn: Single<ApiResponseEntity<[RecommendSpotEntity]>>...) -> MethodStub {
            Given(method: .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lat, lng, startIndex, category), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getSpot(cityCode: Parameter<String>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>, willProduce: (Stubber<Single<ApiResponseEntity<[RecommendSpotEntity]>>>) -> Void) -> MethodStub {
            let willReturn: [Single<ApiResponseEntity<[RecommendSpotEntity]>>] = []
            let given: Given = { Given(method: .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(cityCode, startIndex, category), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<ApiResponseEntity<[RecommendSpotEntity]>>.self)
            willProduce(stubber)
            return given
        }

        public static func getSpot(lat: Parameter<Double>, lng: Parameter<Double>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>, willProduce: (Stubber<Single<ApiResponseEntity<[RecommendSpotEntity]>>>) -> Void) -> MethodStub {
            let willReturn: [Single<ApiResponseEntity<[RecommendSpotEntity]>>] = []
            let given: Given = { Given(method: .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lat, lng, startIndex, category), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<ApiResponseEntity<[RecommendSpotEntity]>>.self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getSpot(cityCode: Parameter<String>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>) -> Verify { Verify(method: .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(cityCode, startIndex, category)) }
        public static func getSpot(lat: Parameter<Double>, lng: Parameter<Double>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>) -> Verify { Verify(method: .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lat, lng, startIndex, category)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getSpot(cityCode: Parameter<String>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>, perform: @escaping (String, Int, SpotCategory) -> Void) -> Perform {
            Perform(method: .m_getSpot__cityCode_cityCodestartIndex_startIndexcategory_category(cityCode, startIndex, category), performs: perform)
        }

        public static func getSpot(lat: Parameter<Double>, lng: Parameter<Double>, startIndex: Parameter<Int>, category: Parameter<SpotCategory>, perform: @escaping (Double, Double, Int, SpotCategory) -> Void) -> Perform {
            Perform(method: .m_getSpot__lat_latlng_lngstartIndex_startIndexcategory_category(lat, lng, startIndex, category), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - WikiDataGatewayProtocol

open class WikiDataGatewayProtocolMock: WikiDataGatewayProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    open func getWikiData(wikiCode: String) -> Single<ApiResponseEntity<WikiDataResponseEntity>> {
        addInvocation(.m_getWikiData__wikiCode_wikiCode(Parameter<String>.value(wikiCode)))
        let perform = methodPerformValue(.m_getWikiData__wikiCode_wikiCode(Parameter<String>.value(wikiCode))) as? (String) -> Void
        perform?(wikiCode)
        var __value: Single<ApiResponseEntity<WikiDataResponseEntity>>
        do {
            __value = try methodReturnValue(.m_getWikiData__wikiCode_wikiCode(Parameter<String>.value(wikiCode))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getWikiData(wikiCode: String). Use given")
            Failure("Stub return value not specified for getWikiData(wikiCode: String). Use given")
        }
        return __value
    }

    fileprivate enum MethodType {
        case m_getWikiData__wikiCode_wikiCode(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_getWikiData__wikiCode_wikiCode(lhsWikicode), .m_getWikiData__wikiCode_wikiCode(rhsWikicode)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsWikicode, rhs: rhsWikicode, with: matcher), lhsWikicode, rhsWikicode, "wikiCode"))
                return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getWikiData__wikiCode_wikiCode(p0): return p0.intValue
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_getWikiData__wikiCode_wikiCode: return ".getWikiData(wikiCode:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func getWikiData(wikiCode: Parameter<String>, willReturn: Single<ApiResponseEntity<WikiDataResponseEntity>>...) -> MethodStub {
            Given(method: .m_getWikiData__wikiCode_wikiCode(wikiCode), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getWikiData(wikiCode: Parameter<String>, willProduce: (Stubber<Single<ApiResponseEntity<WikiDataResponseEntity>>>) -> Void) -> MethodStub {
            let willReturn: [Single<ApiResponseEntity<WikiDataResponseEntity>>] = []
            let given: Given = { Given(method: .m_getWikiData__wikiCode_wikiCode(wikiCode), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<ApiResponseEntity<WikiDataResponseEntity>>.self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getWikiData(wikiCode: Parameter<String>) -> Verify { Verify(method: .m_getWikiData__wikiCode_wikiCode(wikiCode)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getWikiData(wikiCode: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            Perform(method: .m_getWikiData__wikiCode_wikiCode(wikiCode), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - WikiDataUseCaseProtocol

open class WikiDataUseCaseProtocolMock: WikiDataUseCaseProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    open func getWikiData(wikiCode: String) -> Single<ApiResponseEntity<WikiDataResponseEntity>> {
        addInvocation(.m_getWikiData__wikiCode_wikiCode(Parameter<String>.value(wikiCode)))
        let perform = methodPerformValue(.m_getWikiData__wikiCode_wikiCode(Parameter<String>.value(wikiCode))) as? (String) -> Void
        perform?(wikiCode)
        var __value: Single<ApiResponseEntity<WikiDataResponseEntity>>
        do {
            __value = try methodReturnValue(.m_getWikiData__wikiCode_wikiCode(Parameter<String>.value(wikiCode))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for getWikiData(wikiCode: String). Use given")
            Failure("Stub return value not specified for getWikiData(wikiCode: String). Use given")
        }
        return __value
    }

    fileprivate enum MethodType {
        case m_getWikiData__wikiCode_wikiCode(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_getWikiData__wikiCode_wikiCode(lhsWikicode), .m_getWikiData__wikiCode_wikiCode(rhsWikicode)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsWikicode, rhs: rhsWikicode, with: matcher), lhsWikicode, rhsWikicode, "wikiCode"))
                return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getWikiData__wikiCode_wikiCode(p0): return p0.intValue
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_getWikiData__wikiCode_wikiCode: return ".getWikiData(wikiCode:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func getWikiData(wikiCode: Parameter<String>, willReturn: Single<ApiResponseEntity<WikiDataResponseEntity>>...) -> MethodStub {
            Given(method: .m_getWikiData__wikiCode_wikiCode(wikiCode), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getWikiData(wikiCode: Parameter<String>, willProduce: (Stubber<Single<ApiResponseEntity<WikiDataResponseEntity>>>) -> Void) -> MethodStub {
            let willReturn: [Single<ApiResponseEntity<WikiDataResponseEntity>>] = []
            let given: Given = { Given(method: .m_getWikiData__wikiCode_wikiCode(wikiCode), products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<ApiResponseEntity<WikiDataResponseEntity>>.self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getWikiData(wikiCode: Parameter<String>) -> Verify { Verify(method: .m_getWikiData__wikiCode_wikiCode(wikiCode)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getWikiData(wikiCode: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            Perform(method: .m_getWikiData__wikiCode_wikiCode(wikiCode), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        queue.sync { invocations.append(call) }
    }

    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: file, line: line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }

    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        matchingCalls(method.method, file: file, line: line).count
    }

    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }

    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }

    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

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

    open func saveCitySearchResult(prefCode: Int, cityName: String, lat: Double?, lng: Double?) -> Single<Result<SearchResultObject, DataBaseError>> {
        addInvocation(.m_saveCitySearchResult__prefCode_prefCodecityName_cityNamelat_latlng_lng(Parameter<Int>.value(prefCode), Parameter<String>.value(cityName), Parameter<Double?>.value(lat), Parameter<Double?>.value(lng)))
        let perform = methodPerformValue(.m_saveCitySearchResult__prefCode_prefCodecityName_cityNamelat_latlng_lng(Parameter<Int>.value(prefCode), Parameter<String>.value(cityName), Parameter<Double?>.value(lat), Parameter<Double?>.value(lng))) as? (Int, String, Double?, Double?) -> Void
        perform?(prefCode, cityName, lat, lng)
        var __value: Single<Result<SearchResultObject, DataBaseError>>
        do {
            __value = try methodReturnValue(.m_saveCitySearchResult__prefCode_prefCodecityName_cityNamelat_latlng_lng(Parameter<Int>.value(prefCode), Parameter<String>.value(cityName), Parameter<Double?>.value(lat), Parameter<Double?>.value(lng))).casted()
        } catch {
            onFatalFailure("Stub return value not specified for saveCitySearchResult(prefCode: Int, cityName: String, lat: Double?, lng: Double?). Use given")
            Failure("Stub return value not specified for saveCitySearchResult(prefCode: Int, cityName: String, lat: Double?, lng: Double?). Use given")
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
        case m_saveCitySearchResult__prefCode_prefCodecityName_cityNamelat_latlng_lng(Parameter<Int>, Parameter<String>, Parameter<Double?>, Parameter<Double?>)
        case m_setCityLocation__id_idlat_latlng_lng(Parameter<String>, Parameter<Double>, Parameter<Double>)
        case m_getCitySearchResult

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case let (.m_saveCitySearchResult__prefCode_prefCodecityName_cityNamelat_latlng_lng(lhsPrefcode, lhsCityname, lhsLat, lhsLng), .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamelat_latlng_lng(rhsPrefcode, rhsCityname, rhsLat, rhsLng)):
                var results: [Matcher.ParameterComparisonResult] = []
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPrefcode, rhs: rhsPrefcode, with: matcher), lhsPrefcode, rhsPrefcode, "prefCode"))
                results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCityname, rhs: rhsCityname, with: matcher), lhsCityname, rhsCityname, "cityName"))
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
            case let .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamelat_latlng_lng(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case let .m_setCityLocation__id_idlat_latlng_lng(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case .m_getCitySearchResult: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamelat_latlng_lng: return ".saveCitySearchResult(prefCode:cityName:lat:lng:)"
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

        public static func saveCitySearchResult(prefCode: Parameter<Int>, cityName: Parameter<String>, lat: Parameter<Double?>, lng: Parameter<Double?>, willReturn: Single<Result<SearchResultObject, DataBaseError>>...) -> MethodStub {
            Given(method: .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamelat_latlng_lng(prefCode, cityName, lat, lng), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func setCityLocation(id: Parameter<String>, lat: Parameter<Double>, lng: Parameter<Double>, willReturn: Single<Result<SearchResultObject, DataBaseError>>...) -> MethodStub {
            Given(method: .m_setCityLocation__id_idlat_latlng_lng(id, lat, lng), products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getCitySearchResult(willReturn: Single<Result<[SearchResultObject], DataBaseError>>...) -> MethodStub {
            Given(method: .m_getCitySearchResult, products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func saveCitySearchResult(prefCode: Parameter<Int>, cityName: Parameter<String>, lat: Parameter<Double?>, lng: Parameter<Double?>, willProduce: (Stubber<Single<Result<SearchResultObject, DataBaseError>>>) -> Void) -> MethodStub {
            let willReturn: [Single<Result<SearchResultObject, DataBaseError>>] = []
            let given: Given = { Given(method: .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamelat_latlng_lng(prefCode, cityName, lat, lng), products: willReturn.map { StubProduct.return($0 as Any) }) }()
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

        public static func saveCitySearchResult(prefCode: Parameter<Int>, cityName: Parameter<String>, lat: Parameter<Double?>, lng: Parameter<Double?>) -> Verify { Verify(method: .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamelat_latlng_lng(prefCode, cityName, lat, lng)) }
        public static func setCityLocation(id: Parameter<String>, lat: Parameter<Double>, lng: Parameter<Double>) -> Verify { Verify(method: .m_setCityLocation__id_idlat_latlng_lng(id, lat, lng)) }
        public static func getCitySearchResult() -> Verify { Verify(method: .m_getCitySearchResult) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func saveCitySearchResult(prefCode: Parameter<Int>, cityName: Parameter<String>, lat: Parameter<Double?>, lng: Parameter<Double?>, perform: @escaping (Int, String, Double?, Double?) -> Void) -> Perform {
            Perform(method: .m_saveCitySearchResult__prefCode_prefCodecityName_cityNamelat_latlng_lng(prefCode, cityName, lat, lng), performs: perform)
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

    fileprivate enum MethodType {
        case m_loadedViews
        case p_searchHistoryList_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_loadedViews, .m_loadedViews): return .match
            case (.p_searchHistoryList_get, .p_searchHistoryList_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_loadedViews: return 0
            case .p_searchHistoryList_get: return 0
            }
        }

        func assertionName() -> String {
            switch self {
            case .m_loadedViews: return ".loadedViews()"
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
        public static var searchHistoryList: Verify { Verify(method: .p_searchHistoryList_get) }
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

    fileprivate enum MethodType {
        case m_getCitySearchResult

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getCitySearchResult, .m_getCitySearchResult): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getCitySearchResult: return 0
            }
        }

        func assertionName() -> String {
            switch self {
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

        public static func getCitySearchResult(willReturn: Single<Result<[SearchResultEntity], DataBaseError>>...) -> MethodStub {
            Given(method: .m_getCitySearchResult, products: willReturn.map { StubProduct.return($0 as Any) })
        }

        public static func getCitySearchResult(willProduce: (Stubber<Single<Result<[SearchResultEntity], DataBaseError>>>) -> Void) -> MethodStub {
            let willReturn: [Single<Result<[SearchResultEntity], DataBaseError>>] = []
            let given: Given = { Given(method: .m_getCitySearchResult, products: willReturn.map { StubProduct.return($0 as Any) }) }()
            let stubber = given.stub(for: Single<Result<[SearchResultEntity], DataBaseError>>.self)
            willProduce(stubber)
            return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getCitySearchResult() -> Verify { Verify(method: .m_getCitySearchResult) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

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

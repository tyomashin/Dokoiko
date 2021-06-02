// Generated using Sourcery 1.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Generated with SwiftyMocky 4.0.4

@testable import Dokoiko
import Foundation
import RxBlocking
import RxSwift
import SwiftyMocky
import XCTest

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

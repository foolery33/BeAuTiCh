

import NeedleFoundation
import RswiftResources
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class MainScreenComponentDependencyf7fb8b48e001394384acProvider: MainScreenComponentDependency {
    var getDaysOfWeekForDateUseCase: GetDaysOfWeekForDateUseCase {
        return mainComponent.getDaysOfWeekForDateUseCase
    }
    var getWeekdayIndexForDateUseCase: GetWeekdayIndexForDateUseCase {
        return mainComponent.getWeekdayIndexForDateUseCase
    }
    var getDayOfWeekByDateUseCase: GetDayOfWeekByDateUseCase {
        return mainComponent.getDayOfWeekByDateUseCase
    }
    var getDayOfMonthByDateUseCase: GetDayOfMonthByDateUseCase {
        return mainComponent.getDayOfMonthByDateUseCase
    }
    var getDateWithOffsetUseCase: GetDateWithOffsetUseCase {
        return mainComponent.getDateWithOffsetUseCase
    }
    var isTodayUseCase: IsTodayUseCase {
        return mainComponent.isTodayUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->MainScreenComponent
private func factoryd2e546a960c33ef2225f0ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MainScreenComponentDependencyf7fb8b48e001394384acProvider(mainComponent: parent1(component) as! MainComponent)
}
private class StartComponentDependencya3fd516b65f907d47aa7Provider: StartComponentDependency {


    init() {

    }
}
/// ^->MainComponent->StartComponent
private func factorydf30084d4812375c9b62e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return StartComponentDependencya3fd516b65f907d47aa7Provider()
}
private class SearchComponentDependency1207f6d8cbd8351560b4Provider: SearchComponentDependency {
    var appointmentRepository: AppointmentRepository {
        return mainComponent.appointmentRepository
    }
    var convertISOToReadableDateAndTimeUseCase: ConvertISOToReadableDateAndTimeUseCase {
        return mainComponent.convertISOToReadableDateAndTimeUseCase
    }
    var getFilteredAppointmentListUseCase: GetFilteredAppointmentListUseCase {
        return mainComponent.getFilteredAppointmentListUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->SearchComponent
private func factory2746832551408832f06d0ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return SearchComponentDependency1207f6d8cbd8351560b4Provider(mainComponent: parent1(component) as! MainComponent)
}
private class FilterComponentDependencye4de2e473c135cffe41bProvider: FilterComponentDependency {


    init() {

    }
}
/// ^->MainComponent->FilterComponent
private func factory6347d5e031963ee794f4e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return FilterComponentDependencye4de2e473c135cffe41bProvider()
}
private class RegisterComponentDependencyProtocol69bbe0c4d51768ae4d23Provider: RegisterComponentDependencyProtocol {


    init() {

    }
}
/// ^->MainComponent->RegisterComponent
private func factory49735e63dbc2c5fc6d79e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RegisterComponentDependencyProtocol69bbe0c4d51768ae4d23Provider()
}
private class LoginComponentDependency09f1bea0f04d764af082Provider: LoginComponentDependency {


    init() {

    }
}
/// ^->MainComponent->LoginComponent
private func factory7d788d11c001389505f7e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return LoginComponentDependency09f1bea0f04d764af082Provider()
}

#else
extension MainComponent: Registration {
    public func registerItems() {


    }
}
extension MainScreenComponent: Registration {
    public func registerItems() {
        keyPathToName[\MainScreenComponentDependency.getDaysOfWeekForDateUseCase] = "getDaysOfWeekForDateUseCase-GetDaysOfWeekForDateUseCase"
        keyPathToName[\MainScreenComponentDependency.getWeekdayIndexForDateUseCase] = "getWeekdayIndexForDateUseCase-GetWeekdayIndexForDateUseCase"
        keyPathToName[\MainScreenComponentDependency.getDayOfWeekByDateUseCase] = "getDayOfWeekByDateUseCase-GetDayOfWeekByDateUseCase"
        keyPathToName[\MainScreenComponentDependency.getDayOfMonthByDateUseCase] = "getDayOfMonthByDateUseCase-GetDayOfMonthByDateUseCase"
        keyPathToName[\MainScreenComponentDependency.getDateWithOffsetUseCase] = "getDateWithOffsetUseCase-GetDateWithOffsetUseCase"
        keyPathToName[\MainScreenComponentDependency.isTodayUseCase] = "isTodayUseCase-IsTodayUseCase"
    }
}
extension StartComponent: Registration {
    public func registerItems() {

    }
}
extension SearchComponent: Registration {
    public func registerItems() {
        keyPathToName[\SearchComponentDependency.appointmentRepository] = "appointmentRepository-AppointmentRepository"
        keyPathToName[\SearchComponentDependency.convertISOToReadableDateAndTimeUseCase] = "convertISOToReadableDateAndTimeUseCase-ConvertISOToReadableDateAndTimeUseCase"
        keyPathToName[\SearchComponentDependency.getFilteredAppointmentListUseCase] = "getFilteredAppointmentListUseCase-GetFilteredAppointmentListUseCase"
    }
}
extension FilterComponent: Registration {
    public func registerItems() {

    }
}
extension RegisterComponent: Registration {
    public func registerItems() {

    }
}
extension LoginComponent: Registration {
    public func registerItems() {

    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->MainComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->MainComponent->MainScreenComponent", factoryd2e546a960c33ef2225f0ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->StartComponent", factorydf30084d4812375c9b62e3b0c44298fc1c149afb)
    registerProviderFactory("^->MainComponent->SearchComponent", factory2746832551408832f06d0ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->FilterComponent", factory6347d5e031963ee794f4e3b0c44298fc1c149afb)
    registerProviderFactory("^->MainComponent->RegisterComponent", factory49735e63dbc2c5fc6d79e3b0c44298fc1c149afb)
    registerProviderFactory("^->MainComponent->LoginComponent", factory7d788d11c001389505f7e3b0c44298fc1c149afb)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}

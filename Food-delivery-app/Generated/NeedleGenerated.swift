

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
    var appointmentRepository: AppointmentRepository {
        return mainComponent.appointmentRepository
    }
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
    var getSortedWeekAppointmentsUseCase: GetSortedWeekAppointmentsUseCase {
        return mainComponent.getSortedWeekAppointmentsUseCase
    }
    var changeDateTimeStringToHhMmUseCase: ChangeDateTimeStringToHhMmUseCase {
        return mainComponent.changeDateTimeStringToHhMmUseCase
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
private class DetailsAppointmentComponentDependencycc9f4102fc9362a9f386Provider: DetailsAppointmentComponentDependency {
    var appointmentRepository: AppointmentRepository {
        return mainComponent.appointmentRepository
    }
    var convertStringToDateDdMmYyyyHhMmSsUseCase: ConvertStringToDateDdMmYyyyHhMmSsUseCase {
        return mainComponent.convertStringToDateDdMmYyyyHhMmSsUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->DetailsAppointmentComponent
private func factoryfbaf57f0de8177160dce0ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return DetailsAppointmentComponentDependencycc9f4102fc9362a9f386Provider(mainComponent: parent1(component) as! MainComponent)
}
private class ServiceSelectionComponentDependency5628e884730da5d9efb6Provider: ServiceSelectionComponentDependency {
    var servicesRepository: ServicesRepository {
        return mainComponent.servicesRepository
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->ServiceSelectionComponent
private func factory7199151049f30c7d4fa40ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ServiceSelectionComponentDependency5628e884730da5d9efb6Provider(mainComponent: parent1(component) as! MainComponent)
}
private class YourServicesComponentDependencyd4e3d4cc6d212e056730Provider: YourServicesComponentDependency {
    var subscribeRepository: SubscribeRepository {
        return mainComponent.subscribeRepository
    }
    var servicesRepository: ServicesRepository {
        return mainComponent.servicesRepository
    }
    var convertToTimeHhMmSsUseCase: ConvertToTimeHhMmSsUseCase {
        return mainComponent.convertToTimeHhMmSsUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->YourServicesComponent
private func factory1cd1709ea24af3b2cb100ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return YourServicesComponentDependencyd4e3d4cc6d212e056730Provider(mainComponent: parent1(component) as! MainComponent)
}
private class SettingsComponentDependency7fa547a58a11332b68f1Provider: SettingsComponentDependency {


    init() {

    }
}
/// ^->MainComponent->SettingsComponent
private func factory86a73304bebb2197a1eee3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return SettingsComponentDependency7fa547a58a11332b68f1Provider()
}
private class InformationSubscribeComponentDependencyc4c58976cf5886a11075Provider: InformationSubscribeComponentDependency {
    var subscribeRepository: SubscribeRepository {
        return mainComponent.subscribeRepository
    }
    var convertStringToDateDdMmYyyyUseCase: ConvertStringToDateDdMmYyyyUseCase {
        return mainComponent.convertStringToDateDdMmYyyyUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->InformationSubscribeComponent
private func factorycc7c0eb6a29b4b47dd540ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return InformationSubscribeComponentDependencyc4c58976cf5886a11075Provider(mainComponent: parent1(component) as! MainComponent)
}
private class FilterComponentDependencye4de2e473c135cffe41bProvider: FilterComponentDependency {
    var updatePriceUseCase: UpdatePriceUseCase {
        return mainComponent.updatePriceUseCase
    }
    var convertDateToISOUseCase: ConvertDateToISOUseCase {
        return mainComponent.convertDateToISOUseCase
    }
    var convertDateToDdMmYyyyUseCase: ConvertDateToDdMmYyyyUseCase {
        return mainComponent.convertDateToDdMmYyyyUseCase
    }
    var convertISODateStringToDdMmYyyyUseCase: ConvertISODateStringToDdMmYyyyUseCase {
        return mainComponent.convertISODateStringToDdMmYyyyUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->FilterComponent
private func factory6347d5e031963ee794f40ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return FilterComponentDependencye4de2e473c135cffe41bProvider(mainComponent: parent1(component) as! MainComponent)
}
private class EditAppointmentComponentDependencyd81d334ea80f0b03a059Provider: EditAppointmentComponentDependency {
    var convertDateToDdMmYyyyHhMmSsUseCase: ConvertDateToDdMmYyyyHhMmSsUseCase {
        return mainComponent.convertDateToDdMmYyyyHhMmSsUseCase
    }
    var convertDdMmYyyyHhMmSsToISOUseCase: ConvertDdMmYyyyHhMmSsToISOUseCase {
        return mainComponent.convertDdMmYyyyHhMmSsToISOUseCase
    }
    var appointmentRepository: AppointmentRepository {
        return mainComponent.appointmentRepository
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->EditAppointmentComponent
private func factory47f0d97746204a98bae80ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EditAppointmentComponentDependencyd81d334ea80f0b03a059Provider(mainComponent: parent1(component) as! MainComponent)
}
private class RegisterComponentDependencyProtocol69bbe0c4d51768ae4d23Provider: RegisterComponentDependencyProtocol {
    var authRepository: AuthRepository {
        return mainComponent.authRepository
    }
    var getRegisterValidationErrorUseCase: GetRegisterValidationErrorUseCase {
        return mainComponent.getRegisterValidationErrorUseCase
    }
    var saveTokensUseCase: SaveTokensUseCase {
        return mainComponent.saveTokensUseCase
    }
    var makeFullNameUseCase: MakeFullNameUseCase {
        return mainComponent.makeFullNameUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->RegisterComponent
private func factory49735e63dbc2c5fc6d790ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RegisterComponentDependencyProtocol69bbe0c4d51768ae4d23Provider(mainComponent: parent1(component) as! MainComponent)
}
private class ProfileComponentDependency919001f509df49c9c523Provider: ProfileComponentDependency {
    var profileRepository: ProfileRepository {
        return mainComponent.profileRepository
    }
    var convertPhotoToDataUseCase: ConvertPhotoToDataUseCase {
        return mainComponent.convertPhotoToDataUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->ProfileComponent
private func factory85f38151f9d92062292c0ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ProfileComponentDependency919001f509df49c9c523Provider(mainComponent: parent1(component) as! MainComponent)
}
private class AddAppointmentComponentDependencyae4377318630ce797794Provider: AddAppointmentComponentDependency {
    var convertDateToDdMmYyyyHhMmSsUseCase: ConvertDateToDdMmYyyyHhMmSsUseCase {
        return mainComponent.convertDateToDdMmYyyyHhMmSsUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->AddAppointmentComponent
private func factoryc2319cbfa45f5603b7590ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AddAppointmentComponentDependencyae4377318630ce797794Provider(mainComponent: parent1(component) as! MainComponent)
}
private class LoginComponentDependency09f1bea0f04d764af082Provider: LoginComponentDependency {
    var authRepository: AuthRepository {
        return mainComponent.authRepository
    }
    var getLoginValidationErrorUseCase: GetLoginValidationErrorUseCase {
        return mainComponent.getLoginValidationErrorUseCase
    }
    var saveTokensUseCase: SaveTokensUseCase {
        return mainComponent.saveTokensUseCase
    }
    private let mainComponent: MainComponent
    init(mainComponent: MainComponent) {
        self.mainComponent = mainComponent
    }
}
/// ^->MainComponent->LoginComponent
private func factory7d788d11c001389505f70ae93e637f014511a119(_ component: NeedleFoundation.Scope) -> AnyObject {
    return LoginComponentDependency09f1bea0f04d764af082Provider(mainComponent: parent1(component) as! MainComponent)
}

#else
extension MainComponent: Registration {
    public func registerItems() {


    }
}
extension MainScreenComponent: Registration {
    public func registerItems() {
        keyPathToName[\MainScreenComponentDependency.appointmentRepository] = "appointmentRepository-AppointmentRepository"
        keyPathToName[\MainScreenComponentDependency.getDaysOfWeekForDateUseCase] = "getDaysOfWeekForDateUseCase-GetDaysOfWeekForDateUseCase"
        keyPathToName[\MainScreenComponentDependency.getWeekdayIndexForDateUseCase] = "getWeekdayIndexForDateUseCase-GetWeekdayIndexForDateUseCase"
        keyPathToName[\MainScreenComponentDependency.getDayOfWeekByDateUseCase] = "getDayOfWeekByDateUseCase-GetDayOfWeekByDateUseCase"
        keyPathToName[\MainScreenComponentDependency.getDayOfMonthByDateUseCase] = "getDayOfMonthByDateUseCase-GetDayOfMonthByDateUseCase"
        keyPathToName[\MainScreenComponentDependency.getDateWithOffsetUseCase] = "getDateWithOffsetUseCase-GetDateWithOffsetUseCase"
        keyPathToName[\MainScreenComponentDependency.isTodayUseCase] = "isTodayUseCase-IsTodayUseCase"
        keyPathToName[\MainScreenComponentDependency.getSortedWeekAppointmentsUseCase] = "getSortedWeekAppointmentsUseCase-GetSortedWeekAppointmentsUseCase"
        keyPathToName[\MainScreenComponentDependency.changeDateTimeStringToHhMmUseCase] = "changeDateTimeStringToHhMmUseCase-ChangeDateTimeStringToHhMmUseCase"
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
extension DetailsAppointmentComponent: Registration {
    public func registerItems() {
        keyPathToName[\DetailsAppointmentComponentDependency.appointmentRepository] = "appointmentRepository-AppointmentRepository"
        keyPathToName[\DetailsAppointmentComponentDependency.convertStringToDateDdMmYyyyHhMmSsUseCase] = "convertStringToDateDdMmYyyyHhMmSsUseCase-ConvertStringToDateDdMmYyyyHhMmSsUseCase"
    }
}
extension ServiceSelectionComponent: Registration {
    public func registerItems() {
        keyPathToName[\ServiceSelectionComponentDependency.servicesRepository] = "servicesRepository-ServicesRepository"
    }
}
extension YourServicesComponent: Registration {
    public func registerItems() {
        keyPathToName[\YourServicesComponentDependency.subscribeRepository] = "subscribeRepository-SubscribeRepository"
        keyPathToName[\YourServicesComponentDependency.servicesRepository] = "servicesRepository-ServicesRepository"
        keyPathToName[\YourServicesComponentDependency.convertToTimeHhMmSsUseCase] = "convertToTimeHhMmSsUseCase-ConvertToTimeHhMmSsUseCase"
    }
}
extension SettingsComponent: Registration {
    public func registerItems() {

    }
}
extension InformationSubscribeComponent: Registration {
    public func registerItems() {
        keyPathToName[\InformationSubscribeComponentDependency.subscribeRepository] = "subscribeRepository-SubscribeRepository"
        keyPathToName[\InformationSubscribeComponentDependency.convertStringToDateDdMmYyyyUseCase] = "convertStringToDateDdMmYyyyUseCase-ConvertStringToDateDdMmYyyyUseCase"
    }
}
extension FilterComponent: Registration {
    public func registerItems() {
        keyPathToName[\FilterComponentDependency.updatePriceUseCase] = "updatePriceUseCase-UpdatePriceUseCase"
        keyPathToName[\FilterComponentDependency.convertDateToISOUseCase] = "convertDateToISOUseCase-ConvertDateToISOUseCase"
        keyPathToName[\FilterComponentDependency.convertDateToDdMmYyyyUseCase] = "convertDateToDdMmYyyyUseCase-ConvertDateToDdMmYyyyUseCase"
        keyPathToName[\FilterComponentDependency.convertISODateStringToDdMmYyyyUseCase] = "convertISODateStringToDdMmYyyyUseCase-ConvertISODateStringToDdMmYyyyUseCase"
    }
}
extension EditAppointmentComponent: Registration {
    public func registerItems() {
        keyPathToName[\EditAppointmentComponentDependency.convertDateToDdMmYyyyHhMmSsUseCase] = "convertDateToDdMmYyyyHhMmSsUseCase-ConvertDateToDdMmYyyyHhMmSsUseCase"
        keyPathToName[\EditAppointmentComponentDependency.convertDdMmYyyyHhMmSsToISOUseCase] = "convertDdMmYyyyHhMmSsToISOUseCase-ConvertDdMmYyyyHhMmSsToISOUseCase"
        keyPathToName[\EditAppointmentComponentDependency.appointmentRepository] = "appointmentRepository-AppointmentRepository"
    }
}
extension RegisterComponent: Registration {
    public func registerItems() {
        keyPathToName[\RegisterComponentDependencyProtocol.authRepository] = "authRepository-AuthRepository"
        keyPathToName[\RegisterComponentDependencyProtocol.getRegisterValidationErrorUseCase] = "getRegisterValidationErrorUseCase-GetRegisterValidationErrorUseCase"
        keyPathToName[\RegisterComponentDependencyProtocol.saveTokensUseCase] = "saveTokensUseCase-SaveTokensUseCase"
        keyPathToName[\RegisterComponentDependencyProtocol.makeFullNameUseCase] = "makeFullNameUseCase-MakeFullNameUseCase"
    }
}
extension ProfileComponent: Registration {
    public func registerItems() {
        keyPathToName[\ProfileComponentDependency.profileRepository] = "profileRepository-ProfileRepository"
        keyPathToName[\ProfileComponentDependency.convertPhotoToDataUseCase] = "convertPhotoToDataUseCase-ConvertPhotoToDataUseCase"
    }
}
extension AddAppointmentComponent: Registration {
    public func registerItems() {
        keyPathToName[\AddAppointmentComponentDependency.convertDateToDdMmYyyyHhMmSsUseCase] = "convertDateToDdMmYyyyHhMmSsUseCase-ConvertDateToDdMmYyyyHhMmSsUseCase"
    }
}
extension LoginComponent: Registration {
    public func registerItems() {
        keyPathToName[\LoginComponentDependency.authRepository] = "authRepository-AuthRepository"
        keyPathToName[\LoginComponentDependency.getLoginValidationErrorUseCase] = "getLoginValidationErrorUseCase-GetLoginValidationErrorUseCase"
        keyPathToName[\LoginComponentDependency.saveTokensUseCase] = "saveTokensUseCase-SaveTokensUseCase"
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
    registerProviderFactory("^->MainComponent->DetailsAppointmentComponent", factoryfbaf57f0de8177160dce0ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->ServiceSelectionComponent", factory7199151049f30c7d4fa40ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->YourServicesComponent", factory1cd1709ea24af3b2cb100ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->SettingsComponent", factory86a73304bebb2197a1eee3b0c44298fc1c149afb)
    registerProviderFactory("^->MainComponent->InformationSubscribeComponent", factorycc7c0eb6a29b4b47dd540ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->FilterComponent", factory6347d5e031963ee794f40ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->EditAppointmentComponent", factory47f0d97746204a98bae80ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->RegisterComponent", factory49735e63dbc2c5fc6d790ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->ProfileComponent", factory85f38151f9d92062292c0ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->AddAppointmentComponent", factoryc2319cbfa45f5603b7590ae93e637f014511a119)
    registerProviderFactory("^->MainComponent->LoginComponent", factory7d788d11c001389505f70ae93e637f014511a119)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}

//
//  main.swift
//  lesson4
//
//  Created by Андрей Калюжный on 14.03.2021.
//

import Foundation

class Car {
    private let color: Colors//
    private let transmissions: Transmissions
    private let model: String
    private let mark: String
    private let maxSpeed: UInt16
    private var km = 0.0
    private var engineStarted: EngineState{
        didSet{
            let message = engineStarted == .switchedOn ? "\(engineStarted.rawValue)\(getModelAndMarCar())"
                : "\(engineStarted.rawValue)\(getModelAndMarCar())"
            print(message)
        }
    }
    private var doorState: CarDoorState{
        didSet{
            let message = doorState == .open ? "\(CarDoorState.open.rawValue)\(getModelAndMarCar())"
                : "\(CarDoorState.close.rawValue)\(getModelAndMarCar())"
            print(message)
        }
    }
    private static var countCar = 0
    private static var arrCars: Array<Car> = []
    
    //++ Перечисления класса
    enum Colors: String {
        case green = "Зелёный"
        case red = "Красный"
        case black = "Чёрный"
    }
    
    enum Transmissions: String {
        case auto = "Автоматическая"
        case manual = "Механическая"
    }
    
    enum CarDoorState: String{
        case open = "Дверь открыта"
        case close = "Дверь закрыта"
    }
    
    enum EngineState: String{
        case switchedOn = "Двигатель запущен"//
        case SwitchedOff = "Двигатель выключен"
    }
    
    enum TypesOfActions {
        case km, doorState, engineStarted
    }
    // -- Перечисления класса
    
    init(color: Colors, transmissions: Transmissions, model: String, mark: String, maxSpeed: UInt16, doorState: CarDoorState) {
        self.color = color
        self.transmissions = transmissions
        self.model = model
        self.mark = mark
        self.maxSpeed = maxSpeed
        self.doorState = doorState
        self.engineStarted = .SwitchedOff
        Car.countCar += 1
        Car.arrCars.append(self)
    }
    
    func getColor() -> Colors {
        return color
    }
    
    func getTransmissions() -> Transmissions {
        return transmissions
    }
    
    func getModel() -> String {
        return model
    }
    
    func getMark() -> String {
        return mark
    }
    
    func getMaxSpeed() -> UInt16 {
        return maxSpeed
    }
    
    func getKm() -> Double {
        return km
    }
    
    func getDoorState() -> CarDoorState {
        return doorState
    }
    
    func getEngineStarted() -> EngineState {
        return engineStarted
    }
    
    func setKm(_ km: Double) {
        self.km = km
    }
    
    func setDoorState(_ doorState: CarDoorState) {
        self.doorState = doorState
    }
    
    func setEngineStarted(engineState: EngineState) {
        engineStarted = engineState
    }
    
    func getModelAndMarCar() -> String {
        return " у модели \(self.getModel()) марки \(self.getMark())"
    }
    
    func carSignal() -> String {
        return "сигналит авто"
    }
    
    static func getArrayCars() -> Array<Car>{
        return arrCars
    }
    
    static func getCountCars() -> Int {
        return countCar
    }
    
    /*func PerformAnAction(_ action: String, _ someValue: Any) {
        switch action {
        case "km":
            setKm(Double(someValue))
        default:
            <#code#>
        }
    }*/
    
    // просто изменения так как ничерта не могу понять как работать с эти гит хабом
    
    func getInfoCar() -> String {
        return """
            Цвет авто: \(color.rawValue)
            Коробка передач: \(transmissions.rawValue)
            Модель: \(model)
            Марка: \(mark)
            Макисмальная скорость \(maxSpeed) км\\ч
            Пройдено км: \(km)
            Состояние двигателя: \(engineStarted.rawValue)
            Состояние дверей: \(doorState.rawValue)
            """
    }
}


// ++ Наследники
class SportCar: Car {
    private let countSeats: UInt8
    private let engineType: SportCarEngineType
    private static var countSportCar = 0
    
    //++ Перечисления класса
    enum SportCarEngineType: String {
        case electricEngine = "Электрический двигатель"
        case internalCombustionEngine = "Двигатель внутреннего сгорания"
    }
    //-- Перечисления класса
    
    init(color: Car.Colors, transmissions: Car.Transmissions, model: String, mark: String, maxSpeed: UInt16, doorState: Car.CarDoorState, countSeats: UInt8, engineType: SportCarEngineType) {
        self.countSeats = countSeats
        self.engineType = engineType
        super.init(color: color, transmissions: transmissions, model: model, mark: mark, maxSpeed: maxSpeed, doorState: doorState)
        SportCar.countSportCar += 1
    }
    
    override func carSignal() -> String {
        return "сигналит спорт авто"
    }
    
    override func getInfoCar() -> String {
        return super.getInfoCar() + "\n" +
            """
            Количество мест: \(countSeats)
            Вид двигателя: \(engineType.rawValue)
            """
    }
    
    static func getContSportCars() -> Int {
        return countSportCar
    }
}

class TrunkCar: Car {
    private let liftingCapacity: Double
    private var loadingUnloading: ThereIsALoadingUnloading{
        willSet{
            messageToTheUserAboutTheStatusOfTheCarryingCapacity(newValue, withdrawalMethod: WaysToDisplayAMessageToTheUsers.first)
        }
        
        didSet{
            messageToTheUserAboutTheStatusOfTheCarryingCapacity(loadingUnloading, withdrawalMethod: WaysToDisplayAMessageToTheUsers.second)
            loadingUnloading = .restingState
        }
    }
    
    //++ Перечисления класса
    enum WaysToDisplayAMessageToTheUsers{
        case first, second
    }
    
    enum ThereIsALoadingUnloading: String {
        case loading = "Происходит загрузка"
        case unloading = "Происходит выгрузка"
        case restingState = "Состояние покоя загрузка\\выгрузка"
    }
    //-- Перечисления класса
    
    init(color: Car.Colors, transmissions: Car.Transmissions, model: String, mark: String, maxSpeed: UInt16, doorState: Car.CarDoorState, liftingCapacity: Double) {
        self.liftingCapacity = liftingCapacity
        self.loadingUnloading = .restingState
        super.init(color: color, transmissions: transmissions, model: model, mark: mark, maxSpeed: maxSpeed, doorState: doorState)
    }
    
    func getLiftingCapacity() -> Double {
        return liftingCapacity
    }
    
    func getLoadingUnloading() -> ThereIsALoadingUnloading {
        return loadingUnloading
    }
    
    func setLoadingUnloading(loadingUnloading: ThereIsALoadingUnloading) {
        if loadingUnloading == .restingState {
            print("Состояние покоя вручную не устанавливается")
            return
        }
        self.loadingUnloading = loadingUnloading
    }
    
    override func carSignal() -> String {
        return "сигналит грузовое авто"
    }
    
    override func getInfoCar() -> String {
        return super.getInfoCar() + "\n" +
            """
            Грузоподъёмность: \(liftingCapacity) тонн
            Состояние погрузки\\выгрузки: \(loadingUnloading.rawValue)
            """
    }
    
    private func messageToTheUserAboutTheStatusOfTheCarryingCapacity(_ loadingUnloading: ThereIsALoadingUnloading, withdrawalMethod: WaysToDisplayAMessageToTheUsers){
        
        let message: String
        switch withdrawalMethod{
        case .first:
            message = "\(loadingUnloading.rawValue)\(self.getModelAndMarCar())"
        case .second:
            message = loadingUnloading == .loading ? "Загрузка завершена\(self.getModelAndMarCar())" : "Выгрузка завершена\(self.getModelAndMarCar())"
        }
        
        print(message)
    }
}
// -- Наследники

// Создание объектов и работа с ними

var ferrary = SportCar(color: .green, transmissions: .manual, model: "Ferrary", mark: "diablo", maxSpeed: 589, doorState: .close, countSeats: 2, engineType: .internalCombustionEngine)


let indent = "===================================================="

ferrary.setEngineStarted(engineState: .switchedOn)
ferrary.setEngineStarted(engineState: .SwitchedOff)
print(ferrary.carSignal() + ferrary.getModelAndMarCar())
ferrary.setDoorState(.open)
print(indent)

ferrary.setKm(121.8)

var kamaz = TrunkCar(color: .black, transmissions: .manual, model: "Kamaz", mark: "ИЖ-12", maxSpeed: 80, doorState: .close, liftingCapacity: 25.5)

// ещё изменния, можно просто выкладывать изменения без вот этого ведения версионирования?!

kamaz.setKm(12.6)

kamaz.setEngineStarted(engineState: .switchedOn)
kamaz.setLoadingUnloading(loadingUnloading: .restingState)
kamaz.setLoadingUnloading(loadingUnloading: .loading)
kamaz.setLoadingUnloading(loadingUnloading: .unloading)

print(indent)

// Информация о автомобилях
for elCar in Car.getArrayCars(){
    print(elCar.getInfoCar())
    print(indent)
}

// Ещё несколько авто создадим
var bugatty = SportCar(color: .green, transmissions: .auto, model: "Bugatty", mark: "veron", maxSpeed: 708, doorState: .close, countSeats: 2, engineType: .internalCombustionEngine)

var maz = TrunkCar(color: .black, transmissions: .manual, model: "Maz", mark: "Лукашенко стайл", maxSpeed: 95, doorState: .close, liftingCapacity: 35.7)

// Информация сколько создано авто
let infoCountCars = """
                    Информация о количестве авто:
                    Всего авто: \(Car.getCountCars())
                    Всего спортивных авто: \(SportCar.getContSportCars())
                    Всего грузовых авто: \(Car.getCountCars() - SportCar.getContSportCars())
                    """

print(infoCountCars)

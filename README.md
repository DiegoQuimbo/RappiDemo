# RappiDemo

Project info:
App Architecture: MVVM
Dependecy Manager: CocoaPods
Xcode version: 12.5
Most relevant Frameworks: RxSwift, RXCocoa, Alamofire, PromiseKit, Kingfisher


Questions:
- En qué consiste el principio de responsabilidad única? Cuál es su propósito?
El principio de responsabilidad única establece que cada modulo debe tener responsabilidad sobre una sola parte de la funcionalidad del software y la misma debe estar encapsulada en su totalidad por el modulo.
En iOS existen varias arquitecturas que se basan en este principio como es el caso de MVVM y VIPER

- Qué características tiene, según su opinión, un “buen” código o código limpio
Ante todo debe seguir una arquitectura y nomenclatura bien definida para que sea fácil de leer. Las funciones/métodos no pueden superar un cierto numero de lineas y deben tener solo una responsabilidad de manera tal que sea fácil de leer y entender.
También es una buena practica comentar el código en aquellos casos en dónde hay una lógica de negocio compleja. 

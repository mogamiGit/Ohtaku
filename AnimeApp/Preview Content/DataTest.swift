//
//  DataTest.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 1/5/23.
//

import Foundation

struct FilePreview: FileLocation {
    var fileURL: URL {
        Bundle.main.url(forResource: "animeTest", withExtension: "json")!
    }
}

extension AnimesVM {
    static let preview = AnimesVM(persistence: Persistence(fileLocation: FilePreview()))
}

extension Anime {
    static let test = Anime(title: "Ninja Scroll",
                            description: #"Resumen de Complot: Catorce años después de derrotar al guerrero inmortal Himuro Genma y frustrar el Shogun de los malos proyectos de Dark, Kibagami el Jubei sigue vagando por todas partes de Japón como un esgrimidor masterless. Durante su viaje, él encuentra Shigure, una sacerdotisa que nunca ha visto el exterior mundial su pueblo. Pero cuando un grupo de demonios destruye el pueblo y mata a cada uno, Jubei se hace un objetivo principal después de adquirir la Joya de Dragón - una piedra con un origen desconocido. Mientras tanto, Shigure - junto con el monje Dakuan y un ladrón joven llamó Tsubute - viajes al pueblo de Yagyu. Y con dos clanes de demonio que ahora persiguen Shigure, Dakuan debe adquirir otra vez los servicios de Jubei para proteger a la Sacerdotisa de la Luz."#,
                            year: 1993,
                            type: .anime,
                            genres: "Aventuras,Fantasía,Historico,Romance,Shounen,Sobrenatural,Terror",
                            rateStart: "4.5",
                            votes: 129,
                            status: Status.finalizado,
                            followers: 1098,
                            episodes: 13,
                            urlAnime: URL(string: "https://www3.animeflv.net/anime/ninja-scroll")!,
                            image: URL(string: "https://www3.animeflv.net/uploads/animes/covers/560.jpg")!,
                            isWatched: true)
}

import Foundation

struct GenreTemplate {
    let name: String
    let outline: [String]
}

struct GenreConfig {
    static var templates: [GenreTemplate] = [
        GenreTemplate(name: "Fantasy", outline: ["Prologue", "Quest", "Climax"]),
        GenreTemplate(name: "Science Fiction", outline: ["Future World", "Conflict", "Resolution"]),
        GenreTemplate(name: "Mystery", outline: ["Crime", "Investigation", "Reveal"]),
        GenreTemplate(name: "Romance", outline: ["Meet", "Conflict", "Happy Ever After"]),
        GenreTemplate(name: "Thriller", outline: ["Hook", "Chase", "Twist"]),
        GenreTemplate(name: "Horror", outline: ["Tension", "Confrontation", "Survival"]),
        GenreTemplate(name: "Historical", outline: ["Era", "Event", "Legacy"]),
        GenreTemplate(name: "Self Help", outline: ["Problem", "Advice", "Practice"]),
        GenreTemplate(name: "Adventure", outline: ["Call", "Journey", "Reward"]),
        GenreTemplate(name: "LitRPG", outline: ["Login", "Quest", "Level Up"]),
        GenreTemplate(name: "Cyberpunk", outline: ["Neon", "Heist", "Rebellion"]),
        GenreTemplate(name: "Post-Apocalyptic", outline: ["Fallout", "Survival", "Hope"]),
        GenreTemplate(name: "Western", outline: ["Town", "Duel", "Ride Off"]),
        GenreTemplate(name: "Satire", outline: ["Absurdity", "Conflict", "Moral"]),
        GenreTemplate(name: "Urban Fantasy", outline: ["Inciting", "Discovery", "Showdown"]),
        GenreTemplate(name: "Poetry", outline: ["Theme", "Development", "Closing"]),
        GenreTemplate(name: "Dystopian", outline: ["Control", "Resistance", "New Order"]),
        GenreTemplate(name: "Slice of Life", outline: ["Daily Routine", "Conflict", "Growth"]),
        GenreTemplate(name: "Biography", outline: ["Origins", "Achievements", "Legacy"]),
        GenreTemplate(name: "Steampunk", outline: ["Invention", "Rebellion", "Ascend"]) 
    ]
}

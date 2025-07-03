class Country {
  final String name, capital, region, flagUrl;
  final int population;
  final List<String> languages;

  Country({
    required this.name,
    required this.capital,
    required this.region,
    required this.population,
    required this.flagUrl,
    required this.languages,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      capital: json['capital']?[0] ?? 'N/A',
      region: json['region'] ?? 'N/A',
      population: json['population'] ?? 0,
      flagUrl: json['flags']['png'],
      languages: (json['languages'] as Map<String, dynamic>?)
              ?.values.map((l) => l.toString()).toList() ??
          [],
    );
  }
}
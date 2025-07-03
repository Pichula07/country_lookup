import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Corrigido: faltava ponto e vírgula
import '../model/country.dart';
import 'package:intl/intl.dart';

class CountryCard extends StatelessWidget {
  final Country country;
  const CountryCard({super.key, required this.country});

  void _openWikipedia(String countryName) async {
    final url = 'https://en.wikipedia.org/wiki/${countryName.replaceAll(" ", "_")}';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Não foi possível abrir o link: $url';
    }
  }

  Widget infoBlock({required IconData icon, required String label, required String value}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "$label: $value",
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(country.flagUrl, height: 80),
            const SizedBox(height: 20),
            infoBlock(icon: Icons.public, label: 'Country', value: country.name),
            infoBlock(icon: Icons.location_city, label: 'Capital', value: country.capital),
            infoBlock(icon: Icons.language, label: 'Region', value: country.region),
            infoBlock(
                  icon: Icons.people,
                  label: 'Population',
                  value: NumberFormat.decimalPattern().format(country.population),
                ),
            infoBlock(icon: Icons.translate, label: 'Languages', value: country.languages.join(', ')),
            const SizedBox(height: 16),

            /// Botão Wikipedia
            ElevatedButton.icon(
              onPressed: () => _openWikipedia(country.name),
              icon: const Icon(Icons.language),
              label: const Text('See on Wikpedia'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

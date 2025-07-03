import 'package:flutter/material.dart';
import '../controller/country_controller.dart';
import '../widgets/country_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ctrl = CountryController();
  String? _autocompleteValue;

  @override
  void initState() {
    super.initState();
    ctrl.initNames().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Country Lookup',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue t) {
                if (t.text.isEmpty) return const Iterable.empty();
                return ctrl.allNames.where(
                  (c) => c.toLowerCase().contains(t.text.toLowerCase()),
                );
              },
              onSelected: (v) => _autocompleteValue = v,
              fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
                return TextField(
                  controller: textController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: 'Enter exact name',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    color: Colors.black87,
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: options.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);
                        return ListTile(
                          title: Text(option, style: const TextStyle(color: Colors.white)),
                          onTap: () => onSelected(option),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                if (_autocompleteValue != null) {
                  setState(() => ctrl.isLoading = true);
                  await ctrl.searchExact(_autocompleteValue!);
                  setState(() => ctrl.isLoading = false);
                }
              },
              icon: const Icon(Icons.search),
              label: const Text('Search'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ctrl.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ctrl.selected == null
                      ? const Center(
                          child: Text(
                            'No country selected',
                            style: TextStyle(color: Colors.white70),
                          ),
                        )
                      : CountryCard(country: ctrl.selected!),
            ),
          ],
        ),
      ),
    );
  }
}

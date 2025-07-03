import '../model/country.dart';
import '../service/country_service.dart';

class CountryController {
  final service = CountryService();
  List<String> allNames = [];
  Country? selected;
  bool isLoading = false;

  Future<void> initNames() async {
    allNames = await service.loadAllNames();
  }

  Future<void> searchExact(String name) async {
    isLoading = true;
    selected = await service.fetchByName(name);
    isLoading = false;
  }
}
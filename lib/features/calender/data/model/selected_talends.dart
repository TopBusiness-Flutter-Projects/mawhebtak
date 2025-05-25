import 'countries_model.dart';

class SelectedTalends {
  final GetCountriesMainModelData subCategoryIds;
  final String prices;
  final GetCountriesMainModelData countryCurrencies;
  SelectedTalends(
    this.subCategoryIds,
    this.prices,
    this.countryCurrencies,
  );

  factory SelectedTalends.fromJson(Map<String, dynamic> json) {
    return SelectedTalends(
      GetCountriesMainModelData.fromJson(json['subCategoryIds']),
      json['prices'] as String,
      GetCountriesMainModelData.fromJson(json['countryCurrencies']),
    );
  }
}

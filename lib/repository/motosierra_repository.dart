import 'dart:convert';
import 'package:front_carros/model/motosierra_model.dart';
import 'package:http/http.dart' as http;

class MotoSierraRepository {
  final String apiUrl = 'https://b9y3kq0x76.execute-api.us-east-2.amazonaws.com/Prod';

  MotoSierraRepository();

  Future<List<Motosierra>> getMotosierras() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/get_items'),
      );

      if (response.statusCode == 200) {
        List<dynamic> motosierraJson = jsonDecode(response.body)['motosierras'];
        List<Motosierra> motosierras = motosierraJson.map((item) => Motosierra.fromJson(item)).toList();
        return motosierras;
      } else {
        throw Exception('Failed to fetch motosierras');
      }
    } catch (e) {
      print('Error getItems: $e');
      throw Exception('Failed to fetch motosierras');
    }
  }

  Future<void> saveMotosierra(Motosierra motosierra) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/save_item'),
        body: jsonEncode(motosierra.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to save motosierra');
      }
    } catch (e) {
      print('Error saveMotosierra $e');
      throw Exception('Failed to save motosierra');
    }
  }

  Future<void> updateMotosierra(Motosierra motosierra) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/update_item'),
        body: jsonEncode(motosierra.toJson())
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update motosierra');
      }
    } catch (e) {
      print('Error updateItem $e');
      throw Exception('Failed to update Item');
    }
  }

  Future<void> deleteMotosierra(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/delete/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete item');
      }
    } catch (e) {
      print('Error delete item $e');
      throw Exception('Failed to delete item');
    }
  }
}

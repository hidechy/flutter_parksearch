import 'package:flutter/material.dart';

import '../models/park.dart';
import '../repositories/park_repository.dart';

class ParkViewModel extends ChangeNotifier {
  final ParkRepository _repository = ParkRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Park> _parks = [];

  List<Park> get parks => _parks;

  ///
  Future<void> getParkInfo() async {
    _isLoading = true;

    _parks = await _repository.getParkInfo();

    _isLoading = false;

    notifyListeners();
  }
}

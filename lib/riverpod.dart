import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proto/model/riverpod_model.dart';

final riverpod = ChangeNotifierProvider<RiverpodModel>((ref) {
  return RiverpodModel(gender: "", image: "", camera: []);
});
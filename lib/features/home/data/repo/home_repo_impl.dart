import 'package:dartz/dartz.dart';
import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/preferences/preferences.dart';

import '../models/home_filter_model.dart';
import '../models/home_model.dart';

class HomeRepo {
  final BaseApiConsumer dio;
  HomeRepo(this.dio);


}

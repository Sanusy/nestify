import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';

final _serviceLocator = GetIt.instance;

List<Middleware> appMiddleware = [];

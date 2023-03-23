import 'package:nestify/service/dto/home_dto.dart';

abstract class HomeService {
  Future<void> createHomeDraft();

  Future<HomeDto> userHome();

  Future<void> discardCreateHome();
}

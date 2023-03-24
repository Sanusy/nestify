import 'package:nestify/service/dto/home_dto.dart';
import 'package:nestify/service/dto/update_home_dto.dart';

abstract class HomeService {
  Future<void> createHomeDraft();

  Future<void> createHome(UpdateHomeDto homeInfo);

  Future<HomeDto> userHome();

  Future<void> discardCreateHome();
}

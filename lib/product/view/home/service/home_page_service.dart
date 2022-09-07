import '../../../../core/init/network/network_manager.dart';
import '../../../constants/enums/network_endpoints.dart';
import '../model/home_page_model.dart';

class HomePageService {
  Future? getBreeds() async {
    String path = EndPoints.breeds.name;
    final datas = await NetworkManager.instance.dioGet(path, BreedModel());

    if (datas is List<BreedModel>) {
      return datas;
    } else {
      return datas;
    }
  }
}

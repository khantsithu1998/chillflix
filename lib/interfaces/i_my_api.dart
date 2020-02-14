
import 'package:chillflix/model/news_result.dart';

abstract class IMyApi{


  Future<List<Items>> fetchUpcoming();
  Future<List<Items>> fetchSuperhero();
  Future<List<Items>> fetchTopTen();

}

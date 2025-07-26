

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:resturant_app/core/services/items_services.dart';
import 'package:resturant_app/features/home/data/item_data.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
   final DataServices dataServices = DataServices();
  getAllMenuItems({required String id}) async {

    emit(HomeLoading());

    try {
      var allMenuItems = await dataServices.getCategoriesById(id);
     
      List<Itemdata> menuData = [];
      for (var doc in allMenuItems['items'].values) {
       
        menuData.add(Itemdata.fromFirestore(doc, id));
      }
      emit(HomeLoaded(menuData.toSet()));
     
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }


}

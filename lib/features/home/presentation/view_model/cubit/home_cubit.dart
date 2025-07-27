import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:resturant_app/core/services/items_services.dart';
import 'package:resturant_app/features/home/data/item_data.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final DataServices dataServices = DataServices();

  /// Fetches menu items for a specific category by ID
  /// Emits [HomeLoading] while loading, [HomeLoaded] on success, or [HomeError] on failure
  ///
  /// [id] - The category ID to fetch items for
  Future<void> getAllMenuItems({required String id}) async {
    emit(HomeLoading());
    try {
      final categorySnapshot = await dataServices.getCategoriesById(id);

      if (categorySnapshot == null || !categorySnapshot.exists) {
        emit(HomeLoaded(<Itemdata>{}));
        return;
      }

      final categoryData = categorySnapshot.data() as Map<String, dynamic>?;
      final Map<String, dynamic>? items =
          categoryData?['items'] as Map<String, dynamic>?;

      if (items == null || items.isEmpty) {
        emit(HomeLoaded(<Itemdata>{}));
        return;
      }

      final Set<Itemdata> menuData = <Itemdata>{};

      for (final item in items.values) {
        if (item is Map<String, dynamic>) {
          try {
            final itemData = Itemdata.fromFirestore(item, id);
            menuData.add(itemData);
          } catch (itemError) {
            // Log individual item parsing errors but continue processing
            log(
              'Error parsing item for category $id: $itemError',
              name: 'HomeCubit',
            );
          }
        }
      }

      emit(HomeLoaded(menuData));
    } catch (e) {
      log('Error fetching menu items for category $id: $e', name: 'HomeCubit');
      emit(
        HomeError(
          'Failed to load menu items for this category. Please try again.',
        ),
      );
    }
  }

  /// Fetches and returns shuffled menu items from all categories
  /// Emits [HomeLoading] while loading, [HomeLoaded] on success, or [HomeError] on failure
  Future<void> getShuffledItems() async {
    emit(HomeLoading());
    try {
      final allMenuItems = await dataServices.getShuffledItems();

      if (allMenuItems.isEmpty) {
        emit(HomeLoaded(<Itemdata>{}));
        return;
      }

      final Set<Itemdata> menuData = <Itemdata>{};

      for (final doc in allMenuItems) {
        final Map<String, dynamic>? items =
            doc['items'] as Map<String, dynamic>?;
        final String category = doc['category'] as String? ?? 'Unknown';

        if (items != null) {
          for (final item in items.values) {
            if (item is Map<String, dynamic>) {
              try {
                final itemData = Itemdata.fromFirestore(item, category);
                menuData.add(itemData);
              } catch (itemError) {
                // Log individual item parsing errors but continue processing
                log('Error parsing item: $itemError', name: 'HomeCubit');
              }
            }
          }
        }
      }

      emit(HomeLoaded(menuData));
    } catch (e) {
      log('Error fetching shuffled items: $e', name: 'HomeCubit');
      emit(HomeError('Failed to load menu items. Please try again.'));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';
import 'package:resturant_app/features/home/data/item_data.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/enhanced_menu_item_card.dart';
import 'package:resturant_app/features/home/presentation/view_model/cubit/home_cubit.dart';

class EnhancedMenuItems extends StatefulWidget {
  const EnhancedMenuItems({
    super.key,
    required this.isListView,
    this.searchQuery = '',
  });

  final bool isListView;
  final String searchQuery;

  @override
  State<EnhancedMenuItems> createState() => _EnhancedMenuItemsState();
}

class _EnhancedMenuItemsState extends State<EnhancedMenuItems>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _transitionController;
  List<Itemdata> _menuItems = [];
  List<Itemdata> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _transitionController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _animationController.forward();
  }

  @override
  void didUpdateWidget(EnhancedMenuItems oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isListView != widget.isListView) {
      _transitionController.forward().then((_) {
        _transitionController.reverse();
      });
    }

    if (oldWidget.searchQuery != widget.searchQuery) {
      _filterItems();
    }
  }

  void _filterItems() {
    setState(() {
      if (widget.searchQuery.isEmpty) {
        _filteredItems = _menuItems;
      } else {
        _filteredItems = _menuItems.where((item) {
          return item.title.toLowerCase().contains(
                widget.searchQuery.toLowerCase(),
              ) ||
              item.description.toLowerCase().contains(
                widget.searchQuery.toLowerCase(),
              );
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          showSnakBarFaluire(context, state.message);
        }
        if (state is HomeLoaded) {
          setState(() {
            _menuItems = state.menuData.toList();
            _filterItems();
          });
          if (_menuItems.isEmpty) {
            showSnakBarFaluire(context, 'No items found in this category');
          }
        }
        if (state is HomeLoading) {
          setState(() {
            _menuItems = [];
            _filteredItems = [];
          });
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  circleIndeactorCustom(context),
                  const SizedBox(height: 16),
                  Text(
                    'Loading delicious food...',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (_filteredItems.isEmpty && state is! HomeLoading) {
          return _buildEmptyState();
        }

        return AnimatedBuilder(
          animation: _transitionController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 - (_transitionController.value * 0.05),
              child: Opacity(
                opacity: 1.0 - (_transitionController.value * 0.3),
                child: widget.isListView ? _buildListView() : _buildGridView(),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _animationController.value)),
          child: Opacity(
            opacity: _animationController.value,
            child: SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B35).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      size: 40,
                      color: Color(0xFFFF6B35),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    widget.searchQuery.isNotEmpty
                        ? 'No results found'
                        : 'No items available',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    widget.searchQuery.isNotEmpty
                        ? 'Try searching with different keywords'
                        : 'Check back later for new items',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: _filteredItems.length,
          itemBuilder: (context, index) {
            final item = _filteredItems[index];

            return TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: EnhancedMenuItemCard(item: item, isGridView: true),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildListView() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _filteredItems.length,
          itemBuilder: (context, index) {
            final item = _filteredItems[index];

            return TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 400 + (index * 50)),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(-100 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: index == _filteredItems.length - 1 ? 0 : 16,
                      ),
                      child: EnhancedMenuItemCard(
                        item: item,
                        isGridView: false,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

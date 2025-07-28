import 'package:flutter/material.dart';

class BottomNavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final Color? color;
  final Widget Function(BuildContext context)? badgeBuilder;

  BottomNavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.color,
    this.badgeBuilder,
  });
}

class BottomNavState {
  const BottomNavState({
    required this.currentIndex,
    this.isAnimating = false,
    this.lastTapTime,
  });

  final int currentIndex;
  final bool isAnimating;
  final DateTime? lastTapTime;

  BottomNavState copyWith({
    int? currentIndex,
    bool? isAnimating,
    DateTime? lastTapTime,
  }) {
    return BottomNavState(
      currentIndex: currentIndex ?? this.currentIndex,
      isAnimating: isAnimating ?? this.isAnimating,
      lastTapTime: lastTapTime ?? this.lastTapTime,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BottomNavState &&
        other.currentIndex == currentIndex &&
        other.isAnimating == isAnimating &&
        other.lastTapTime == lastTapTime;
  }

  @override
  int get hashCode {
    return Object.hash(currentIndex, isAnimating, lastTapTime);
  }

  @override
  String toString() {
    return 'BottomNavState(currentIndex: $currentIndex, isAnimating: $isAnimating, lastTapTime: $lastTapTime)';
  }
}

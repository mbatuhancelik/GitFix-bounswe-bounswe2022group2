import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnify/core/widgets/buttons/action_button.dart';
import 'package:learnify/core/widgets/list/custom_expansion_tile.dart';
import 'package:learnify/core/widgets/text/annotatable/annotatable_text.dart';
import 'package:learnify/core/widgets/text/base_text.dart';
import 'package:learnify/features/learning-space/models/learning_space_model.dart';
import 'package:learnify/features/learning-space/view/learning_space_detail_screen.dart';
import 'package:learnify/product/language/language_keys.dart';

import 'test_helpers.dart';

void main() {
  testWidgets(
    "Test post list and item widgets.",
    (WidgetTester tester) async {
      const LearningSpace dummyLearningSpace = LearningSpace();
      final LearningSpaceDetailScreen detailScreen =
          LearningSpaceDetailScreen(learningSpace: dummyLearningSpace);
      await tester.pumpWidget(TestHelpers.appWidget(detailScreen));

      final Finder tabFinder =
          TestHelpers.descendantFinder(detailScreen, DefaultTabController);
      expect(tabFinder, findsOneWidget);
      final DefaultTabController tabController =
          tester.widget(tabFinder) as DefaultTabController;
      expect(tabController.initialIndex, 0);

      final Finder postListFinder =
          TestHelpers.descendantFinder(detailScreen, PostList);
      expect(postListFinder, findsOneWidget);

      final Finder listFinder =
          TestHelpers.descendantFinder(detailScreen, SliverList);
      expect(listFinder, findsOneWidget);
      final SliverList sliverList = tester.widget(listFinder) as SliverList;
      final SliverChildBuilderDelegate delegate =
          sliverList.delegate as SliverChildBuilderDelegate;
      expect(delegate.childCount, 21);

      final Finder buttonFinder =
          TestHelpers.descendantFinder(detailScreen, ActionButton);
      expect(buttonFinder, findsOneWidget);
      final ActionButton button = tester.widget(buttonFinder) as ActionButton;
      expect(button.isActive, true);
      expect(button.text, TextKeys.createPost);

      final Finder postFinder =
          TestHelpers.descendantFinder(detailScreen, PostItem);
      final PostItem firstPost = tester.widget(postFinder.first) as PostItem;
      expect(firstPost.itemIndex, 0);

      final Finder expansionTileFinder =
          TestHelpers.descendantFinder(firstPost, CustomExpansionTile);
      expect(expansionTileFinder, findsOneWidget);
      final CustomExpansionTile expansionTile =
          tester.widget(expansionTileFinder) as CustomExpansionTile;
      expect(expansionTile.children.first.runtimeType, BaseText);
      expect(expansionTile.children[1].runtimeType, CarouselSlider);
      expect(expansionTile.children[4].runtimeType, AnnotatableText);
      expect(expansionTile.children.last.runtimeType, Padding);
      final Padding padding = expansionTile.children.last as Padding;
      expect(padding.child.runtimeType, ActionButton);
      final ActionButton? editButton = padding.child as ActionButton?;
      expect(editButton?.isActive, true);
      expect(editButton?.text, TextKeys.editPost);
    },
  );
}

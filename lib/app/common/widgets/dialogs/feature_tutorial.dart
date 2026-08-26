import 'package:flutter/widgets.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/app/common/get_it/get_it.dart';
import 'package:interior_ai/app/common/widgets/dialogs/feature_tutorial_dialog.dart';
import 'package:interior_ai/core/storage/tutorial_storage.dart';

/// Shows a feature's intro tutorial the first time the user opens it, then
/// never again (persisted in [TutorialStorage] until the app is reinstalled).
class FeatureTutorial {
  const FeatureTutorial._();

  static final List<TutorialStep> _interiorSteps = _zip(const [
    AppAsset.interiorTutorial1,
    AppAsset.interiorTutorial2,
    AppAsset.interiorTutorial3,
  ], AppStrings.interiorTutorialSteps);

  static final List<TutorialStep> _styleReferenceSteps = _zip(const [
    AppAsset.styleReferenceTutorial1,
    AppAsset.styleReferenceTutorial2,
  ], AppStrings.styleReferenceTutorialSteps);

  static final List<TutorialStep> _replaceObjectSteps = _zip(const [
    AppAsset.replaceObjectTutorial1,
    AppAsset.replaceObjectTutorial2,
    AppAsset.replaceObjectTutorial3,
  ], AppStrings.replaceObjectTutorialSteps);

  /// Guards against a second dialog being scheduled within the same session
  /// before the async [TutorialStorage.markSeen] write settles.
  static final Set<String> _shownThisSession = {};

  static Future<void> interior(BuildContext context) =>
      _maybeShow(context, 'interior_design', _interiorSteps);

  static Future<void> styleReference(BuildContext context) =>
      _maybeShow(context, 'style_reference', _styleReferenceSteps);

  static Future<void> replaceObject(BuildContext context) =>
      _maybeShow(context, 'replace_object', _replaceObjectSteps);

  static List<TutorialStep> _zip(
    List<AppAsset> images,
    List<String> descriptions,
  ) {
    return [
      for (int i = 0; i < images.length; i++)
        TutorialStep(image: images[i], description: descriptions[i]),
    ];
  }

  static Future<void> _maybeShow(
    BuildContext context,
    String key,
    List<TutorialStep> steps,
  ) async {
    if (_shownThisSession.contains(key)) return;
    final storage = getIt<TutorialStorage>();
    if (storage.hasSeen(key)) return;
    _shownThisSession.add(key);
    await storage.markSeen(key);
    if (!context.mounted) return;
    await FeatureTutorialDialog.show(context, steps);
  }
}

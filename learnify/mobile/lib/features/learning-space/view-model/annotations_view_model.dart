import '../../../../core/base/view-model/base_view_model.dart';
import '../models/annotation/annotation_model.dart';

class AnnotationsViewModel extends BaseViewModel {
  late String _annotationText;
  String get annotationText => _annotationText;
  final List<Annotation> _annotations = <Annotation>[];
  List<Annotation> get annotations => _annotations;

  @override
  void initViewModel() {
    // _annotations = List<Annotation>.generate(5, Annotation.dummy);
  }

  @override
  void disposeViewModel() {}

  @override
  void initView() {}
}

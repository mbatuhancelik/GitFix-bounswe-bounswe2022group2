part of '../../create_learning_space_screen.dart';

class _LearningSpaceForm extends StatelessWidget {
  const _LearningSpaceForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreateLearningSpaceViewModel model =
        context.read<CreateLearningSpaceViewModel>();
    return Form(
      key: model.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
              child: SingleChildScrollView(
            child: _titleField(model.titleController),
          )),
          context.sizedH(.5),
          Flexible(
              child: SingleChildScrollView(
            child: _descriptionField(model.descriptionController),
          )),
          context.sizedH(.5),
          Flexible(child: _participantsField(model.participantsController)),
          Flexible(child: _addedCategories(context)),
          context.sizedH(1.5),
        ],
      ),
    );
  }

  Widget _titleField(TextEditingController controller) => CustomTextFormField(
        maxLines: 1,
        key: CreateLearningSpaceKeys.titleField,
        controller: controller,
        hintText: TextKeys.spaceTitleHint,
        labelText: TextKeys.spaceTitleLabel,
        validator: Validators.name,
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.name,
        padding: const EdgeInsets.all(10),
      );

  Widget _descriptionField(TextEditingController controller) =>
      CustomTextFormField(
        maxLines: 5,
        key: CreateLearningSpaceKeys.titleField,
        controller: controller,
        hintText: TextKeys.spaceDescriptionHint,
        labelText: TextKeys.spaceDescriptionLabel,
        textInputAction: TextInputAction.newline,
        textInputType: TextInputType.multiline,
        padding: const EdgeInsets.all(10),
        validator: Validators.description,
      );

  Widget _participantsField(TextEditingController controller) =>
      CustomTextFormField(
        key: CreateLearningSpaceKeys.participantsField,
        labelText: TextKeys.participantLimit,
        textInputType: TextInputType.number,
        controller: controller,
        maxLength: 3,
        padding: const EdgeInsets.all(10),
      );

  Widget _addedCategories(BuildContext context) => Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        children: <Widget>[
          const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
          const BaseText(TextKeys.categories, textAlign: TextAlign.left),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.width * 3, vertical: context.height),
            child: SelectorHelper<List<String>, CreateLearningSpaceViewModel>()
                .builder(
              (_, CreateLearningSpaceViewModel model) =>
                  model.selectedCategoryNames,
              (BuildContext context, List<String> tagList, _) => Wrap(
                  runSpacing: 5,
                  spacing: 5,
                  children: tagList
                      .map((String tag) => CustomizedChip(tag: tag))
                      .toList()),
            ),
          )
        ],
      ));
}

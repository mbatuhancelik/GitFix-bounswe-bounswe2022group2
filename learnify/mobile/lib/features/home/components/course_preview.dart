part of '../view/home_screen.dart';

class _CoursePreview extends StatelessWidget {
  const _CoursePreview({
    required this.textKey,
    required this.participantNumber,
    // ignore: unused_element
    this.courseImage = IconKeys.learnIllustration,
    Key? key,
  }) : super(key: key);

  final String textKey;
  final int participantNumber;
  final String courseImage;

  @override
  Widget build(BuildContext context) => Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 8,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: DarkAppTheme.orange,
          onTap: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 6),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.width * 4),
                  child: Ink.image(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.width * 4),
                    image: AssetImage(courseImage),
                    height: context.height * 10,
                    width: context.width * 30,
                    fit: BoxFit.cover,
                  )),
              context.sizedH(.5),
              _courseDescription(context),
              context.sizedH(.3)
            ],
          ),
        ),
      );

  Widget _courseDescription(BuildContext context) => Container(
      padding: EdgeInsets.symmetric(horizontal: context.width * 3),
      width: context.width * 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Text(textKey,
                textAlign: TextAlign.left,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis),
          ),
          const Spacer(),
          const Icon(Icons.people_alt_outlined, size: 15),
          Text(participantNumber.toString(), textAlign: TextAlign.right)
        ],
      ));
}
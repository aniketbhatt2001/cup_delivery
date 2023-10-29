import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

AwesomeDialog showSucess(
    BuildContext context, String title, String desc, Function function) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.leftSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.success,
    showCloseIcon: true,
    title: 'Succes',
    descTextStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    desc:
        'Dialog description here..................................................',
    btnOkOnPress: () {
      debugPrint('OnClcik');
    },
    btnOkIcon: Icons.check_circle,
    onDismissCallback: (type) {
      debugPrint('Dialog Dissmiss from callback $type');
    },
  );
}

AwesomeDialog showQuestion(
    BuildContext context, String title, String desc, Function function) {
  return AwesomeDialog(
    context: context,
    descTextStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    dialogType: DialogType.question,
    animType: AnimType.rightSlide,
    headerAnimationLoop: true,
    title: title,
    closeIcon: const Icon(FontAwesomeIcons.circleXmark),
    showCloseIcon: T,
    desc: desc,
    btnOkOnPress: () {
      function();
    },
  );
}

AwesomeDialog showError(BuildContext context, String title, String desc) {
  return AwesomeDialog(
    context: context,
    descTextStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    dialogType: DialogType.error,
    animType: AnimType.rightSlide,
    //showCloseIcon: T,
    headerAnimationLoop: false,
    title: 'Error',
    desc: desc,
    btnOkOnPress: () {},
    btnOkIcon: Icons.cancel,
    btnOkColor: Colors.red,
  );
}

AwesomeDialog showWarnig(
    BuildContext context, String title, String desc, Function function) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    headerAnimationLoop: false,
    descTextStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    animType: AnimType.topSlide,
    showCloseIcon: true,
    closeIcon: const Icon(FontAwesomeIcons.circleXmark),
    title: title,
    desc: desc,
    btnCancelOnPress: () {},
    onDismissCallback: (type) {
      // debugPrint('Dialog Dismiss from callback $type');
    },
    btnOkOnPress: () {
      function();
    },
  );
}

AwesomeDialog showInfoReverse(
    BuildContext context, String title, String desc, Function function) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.infoReverse,
    headerAnimationLoop: true,
    animType: AnimType.bottomSlide,
    title: title,
    descTextStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    reverseBtnOrder: true,
    btnOkOnPress: () {
      function();
    },
    btnCancelOnPress: () {},
    desc: desc,
  );
}

// class WarningDialog extends StatelessWidget {
//   const WarningDialog({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedButton(
//       text: 'Warning Dialog With Custom BTN Style',
//       pressEvent: () {
//         AwesomeDialog(
//           context: context,
//           dialogType: DialogType.warning,
//           headerAnimationLoop: false,
//           animType: AnimType.bottomSlide,
//           title: 'Question',
//           desc: 'Dialog description here...',
//           buttonsTextStyle: const TextStyle(color: Colors.black),
//           showCloseIcon: true,
//           btnCancelOnPress: () {},
//           btnOkOnPress: () {},
//         ).show();
//       },
//     );
//   }
// }

AwesomeDialog showInfoDialog(BuildContext context) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.info,
    borderSide: const BorderSide(
      color: Colors.green,
      width: 2,
    ),
    width: 280,
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: false,
    onDismissCallback: (type) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Dismissed by $type'),
        ),
      );
    },
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: 'INFO',
    desc: 'This Dialog can be dismissed touching outside',
    showCloseIcon: true,
    btnCancelOnPress: () {},
    btnOkOnPress: () {},
  );
}

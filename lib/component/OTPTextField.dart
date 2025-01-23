import 'package:dompet_mal/app/modules/(home)/email_verification/controllers/email_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final int index;
  final EmailVerificationController parentController;

  const OTPTextField({
    required this.controller,
    required this.focusNode,
    required this.index,
    required this.parentController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 32 - 50) / 6,
      height: (MediaQuery.of(context).size.width - 32 - 50) / 6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.backspace) {
              if (controller.text.isEmpty && index > 0) {
                parentController.otpFocusNodes[index - 1].requestFocus();
                parentController.otpControllers[index - 1].text = '';
                parentController.updateOTPValue();
              }
            }
          }
        },
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 6, // Allow paste of 6 digits
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            counterText: "",
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) => parentController.handleInput(index, value),
        ),
      ),
    );
  }
}

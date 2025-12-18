import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/app_dropdown.dart';
import '../../core/widgets/app_textfield.dart';
import '../../service/auth_providers.dart';
import '../../core/constants/app_colors.dart';
import '../chat/group_chat_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  final String? googleName;
  final String? googleEmail;

  const CreateAccountScreen({
    super.key,
    this.googleName,
    this.googleEmail,
  });

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final postalCtrl = TextEditingController();

  bool hidePassword = true;

  String country = "India";
  String? state;
  String? city;
  String gender = "Prefer not to say";
  DateTime? dob;

  @override
  void initState() {
    super.initState();
    nameCtrl.text = widget.googleName ?? "";
    emailCtrl.text = widget.googleEmail ?? "";
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    passwordCtrl.dispose();
    addressCtrl.dispose();
    postalCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProviders>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/icons/SignUp_b.png",
                    height: 42,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 6),
                Text(
                  "Please enter your credentials to proceed",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),

                _label("Full Name"),
                Inputtextfiled(nameCtrl),

                _label("Phone"),
                Inputtextfiled(
                  phoneCtrl,
                  keyboard: TextInputType.phone,
                  filled: true,
                  prefix: SizedBox(
                    width: 70,
                    child: Center(
                      child: Text(
                        "🇮🇳  +91",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),

                _label("Email address"),
                Inputtextfiled(emailCtrl, enabled: false),

                _label("Password"),
                _passwordInput(),
                const SizedBox(height: 4),

                _label("Address"),
                Inputtextfiled(addressCtrl, maxLines: 3),

                _label("Country"),
                appDropdown(country, ["India"], (v) {}),

                _label("State"),
                appDropdown(state, ["Gujarat", "Maharashtra"], (v) {
                  setState(() => state = v);
                }),

                _label("City"),
                appDropdown(city, ["Ahmedabad", "Surat"], (v) {
                  setState(() => city = v);
                }),

                _label("Postal Code"),
                Inputtextfiled(postalCtrl, keyboard: TextInputType.number),

                _label("My date of birth"),
                _datePicker(),

                _label("Gender"),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    _genderOption("Male"),
                    _genderOption("Female"),
                    _genderOption("Prefer not to say"),
                  ],
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: auth.loading ? null : _submit,
                    child: auth.loading
                        ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.loader,
                      ),
                    )
                        : const Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- WIDGETS ----------------

  Widget _genderOption(String value) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () => setState(() => gender = value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: value,
            groupValue: gender,
            onChanged: (v) => setState(() => gender = v!),
            activeColor: AppColors.primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 6),
    child: Text(
      t,
      style: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  // Widget _input(
  //     TextEditingController c, {
  //       TextInputType keyboard = TextInputType.text,
  //       Widget? prefix,
  //       int maxLines = 1,
  //       bool enabled = true,
  //       bool filled = false,
  //       String? hint,
  //     }) {
  //   return TextFormField(
  //     controller: c,
  //     enabled: enabled,
  //     keyboardType: keyboard,
  //     maxLines: maxLines,
  //     validator: (v) => v == null || v.isEmpty ? "Required field" : null,
  //     style: TextStyle(
  //       fontSize: 16,
  //       color: AppColors.textPrimary,
  //     ),
  //     decoration: InputDecoration(
  //       hintText: hint,
  //       hintStyle: TextStyle(
  //         fontSize: 16,
  //         color: AppColors.textSecondary,
  //       ),
  //       contentPadding:
  //       const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
  //       prefixIcon: prefix,
  //       filled: filled,
  //       fillColor: filled ? AppColors.inputBg : AppColors.white,
  //       border: _border(),
  //       enabledBorder: _border(),
  //       focusedBorder: _border(),
  //       disabledBorder: _border(color: AppColors.border.withOpacity(0.5)),
  //     ),
  //   );
  // }

  OutlineInputBorder _border({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: color ?? AppColors.inputBg,
        width: 1.2,
      ),
    );
  }

  Widget _passwordInput() {
    OutlineInputBorder border({Color? color}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: color ?? AppColors.inputBg,
          width: 1.2,
        ),
      );
    }

    return TextFormField(
      controller: passwordCtrl,
      obscureText: hidePassword,
      validator: (v) => v == null || v.length < 6
          ? "Password must have: uppercase, number & spl character"
          : null,
      decoration: InputDecoration(
        border: border(),
        enabledBorder: border(),
        focusedBorder: border(),
        errorBorder: border(color: Colors.redAccent),
        focusedErrorBorder: border(color: Colors.redAccent),
        suffixIcon: IconButton(
          icon: Icon(
            hidePassword ? Icons.visibility_off : Icons.visibility,
            color: AppColors.icon,
          ),
          onPressed: () {
            setState(() => hidePassword = !hidePassword);
          },
        ),
      ),
    );
  }


  // Widget _dropdown(
  //     String? value,
  //     List<String> items,
  //     ValueChanged<String?> onChanged,
  //     ) {
  //   return DropdownButtonFormField<String>(
  //     value: value,
  //     icon: Icon(Icons.keyboard_arrow_down, color: AppColors.icon),
  //     items: items
  //         .map(
  //           (e) => DropdownMenuItem<String>(
  //         value: e,
  //         child: Text(e, style: const TextStyle(fontSize: 16)),
  //       ),
  //     )
  //         .toList(),
  //     onChanged: onChanged,
  //     validator: (v) => v == null ? "Required field" : null,
  //     decoration: InputDecoration(
  //       contentPadding:
  //       const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
  //       border: _border(),
  //       enabledBorder: _border(),
  //       focusedBorder: _border(),
  //       errorBorder: _border(color: Colors.redAccent),
  //     ),
  //   );
  // }

  Widget _datePicker() {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
          initialDate: dob ?? DateTime(2000),
        );
        if (picked != null) {
          setState(() => dob = picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          border: _border(),
          enabledBorder: _border(),
          focusedBorder: _border(),
          suffixIcon: Icon(
            Icons.calendar_month,
            color: AppColors.icon,
          ),
        ),
        child: Text(
          dob == null
              ? "Select"
              : "${dob!.day.toString().padLeft(2, '0')}/"
              "${dob!.month.toString().padLeft(2, '0')}/"
              "${dob!.year}",
          style: TextStyle(
            fontSize: 16,
            color: dob == null
                ? AppColors.textSecondary
                : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }


  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (dob == null || state == null || city == null) {
      _showMsg("Please fill all required fields");
      return;
    }

    final result = await context.read<AuthProviders>().createAccount(
      name: nameCtrl.text.trim(),
      email: emailCtrl.text.trim(),
      phone: phoneCtrl.text.trim(),
      gender: gender,
      address: addressCtrl.text.trim(),
      city: city!,
      state: state!,
      dob: "${dob!.day}/${dob!.month}/${dob!.year}",
    );

    if (!mounted) return;

    if (result == "success" || result == "already") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const GroupChatScreen()),
      );
    } else {
      _showMsg("Account creation failed");
    }
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}

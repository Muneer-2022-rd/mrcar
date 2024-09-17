import 'package:cars_equipments_shop/features/settings/lang/data/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/shared/data/local/shared_local.dart';
import '../../../../../core/shared/widgets/custome_loading.dart';
import '../../../../../core/shared/widgets/custome_text_form_field.dart';
import '../../../../../core/validation/validator.dart';
import '../../data/local/login_local.dart';
import '../bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController userEmail;
  final TextEditingController userPassword;
  final bool showHiddenPassword;
  final bool isChecked;
  final Function() onTogglePassword;
  final Function() onToggleRememberMe;
  final Function() onLogin;
  final Function() onNavigateToRegister;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.userEmail,
    required this.userPassword,
    required this.showHiddenPassword,
    required this.isChecked,
    required this.onTogglePassword,
    required this.onToggleRememberMe,
    required this.onLogin,
    required this.onNavigateToRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomeTextFormField(
            labelText: SharedConstants.sharedFormEmail.tr(context),
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            controller: userEmail,
            validator: (value) => TValidator.validateEmail(value),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          TextFormField(
            validator: (value) => TValidator.validatePassword(value),
            controller: userPassword,
            keyboardType: TextInputType.text,
            obscureText: showHiddenPassword,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: showHiddenPassword
                    ? const Icon(Iconsax.eye)
                    : const Icon(Iconsax.eye_slash),
                onPressed: onTogglePassword,
              ),
              label: Text(SharedConstants.sharedFormPassword.tr(context)),
              prefixIcon: const Icon(Icons.fingerprint),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    visualDensity: VisualDensity.comfortable,
                    activeColor: Theme.of(context).primaryColor,
                    value: isChecked,
                    onChanged: (value) => onToggleRememberMe(),
                  ),
                  Text(
                    LoginConstants.loginRememberMe.tr(context),
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  LoginConstants.loginFormForgetPassword.tr(context),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          const SizedBox(height: TSizes.spaceBtnItems),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return state is LoginLoadingState
                  ? const LoadingWidget()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onLogin,
                        child: Text(
                          SharedConstants.sharedFormLogin.tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 18),
                        ),
                      ),
                    );
            },
          ),
          const SizedBox(height: TSizes.spaceBtnItems),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onNavigateToRegister,
              child: Text(
                SharedConstants.sharedFormRegister.tr(context),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtnItems),
        ],
      ),
    );
  }
}

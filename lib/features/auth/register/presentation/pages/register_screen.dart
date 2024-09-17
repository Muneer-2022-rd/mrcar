import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cars_equipments_shop/core/functions/navigation.dart';
import 'package:cars_equipments_shop/core/shared/data/local/shared_local.dart';
import 'package:cars_equipments_shop/features/auth/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/sizes.dart';
import '../../../../../core/functions/helper_functions.dart';
import '../../../../../core/functions/pick_image.dart';
import '../../../../../core/shared/widgets/custome_app_bar.dart';
import '../../../../../core/shared/widgets/upload_single_file_image.dart';
import '../bloc/register_bloc.dart';
import '../widgets/additional_information_widget.dart';
import '../widgets/agreement_section_widget.dart';
import '../widgets/personal_information_widget.dart';
import 'register_error_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;
  late TextEditingController _phoneController;

  bool _showPassword = true;
  bool _isTermsAccepted = false;
  String? _gender;
  String _selectedCountryCode = "AE";
  DateTime? _selectedDate;
  File? _thumbnail;

  SharedPreferences? _sharedPreferences;
  String? _language;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadSharedPreferences();
  }

  void _initializeControllers() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _usernameController = TextEditingController();
    _phoneController = TextEditingController();
  }

  Future<void> _loadSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _language = _sharedPreferences?.getString("LOCALE") ?? "en";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleTermsAcceptance() {
    setState(() {
      _isTermsAccepted = !_isTermsAccepted;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _pickImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        _thumbnail = File(pickedImage.path);
      });
    }
  }

  void _deleteImage() {
    setState(() {
      _thumbnail = null;
    });
  }

  void _submitForm(BuildContext context) {
    if (!_isTermsAccepted) {
      _showSnackBar(context, "Please accept the terms and conditions");
      return;
    }

    if (!_formKey.currentState!.validate() ||
        _selectedDate == null ||
        _thumbnail == null) {
      _showSnackBar(context, "Please complete all required fields");
      return;
    }

    BlocProvider.of<RegisterBloc>(context).add(
      SignUpEvent(
        userName: _usernameController.text,
        userFirst: _firstNameController.text,
        userLast: _lastNameController.text,
        userEmail: _emailController.text,
        userGender: _gender!,
        userPhone: PhoneNumberModel(
          phoneNumber: _phoneController.text,
          countryCode: _selectedCountryCode,
        ),
        userDateBirth: THelperFunctions.getFormattedDate(_selectedDate!),
        password: _passwordController.text,
        userImageProfile: _thumbnail,
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    THelperFunctions.showSnackBar(
      context: context,
      title: "Error",
      message: message,
      type: ContentType.failure,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          push(context, RegisterErrorScreen(subTitle: state.errorMsg));
        } else if (state is RegisterSuccessState) {
          pushNamed(context, PagesName.registerSuccessPage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomeAppBar(
            title: Text("Create Account",
                style: Theme.of(context).textTheme.headlineLarge),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  UploadSingleFileImage(
                    thmbnail: _thumbnail,
                    deleteImage: _deleteImage,
                    uploadImage: _pickImage,
                    title: "Profile Picture",
                  ),
                  PersonalInfoForm(
                    userFirst: _firstNameController,
                    userLast: _lastNameController,
                    userName: _usernameController,
                    userEmail: _emailController,
                    userPassword: _passwordController,
                    showHiddenPassword: _showPassword,
                    toggolePasswordEvent: _togglePasswordVisibility,
                  ),
                  AdditionalInfoForm(
                    selectedDate: _selectedDate,
                    userGender: _gender,
                    userPhone: _phoneController,
                    lang: _language ?? "en",
                    selectedCountryIsoCode: _selectedCountryCode,
                    selectDate: _selectDate,
                    changeGender: (gender) => setState(() => _gender = gender),
                    changeSelectedCountryIsoCode: (country) =>
                        setState(() => _selectedCountryCode = country.code),
                  ),
                  AgreementSection(
                    isChecked: _isTermsAccepted,
                    toggoleRememberMeEvent: _toggleTermsAcceptance,
                  ),
                  if (state is RegisterLoadingState)
                    const CircularProgressIndicator()
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _submitForm(context),
                        child: Text("Register",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.white)),
                      ),
                    ),
                  const SizedBox(height: TSizes.spaceBtnItems),
                  Wrap(
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () => pushNamedAndRemoveUntil(
                            context, PagesName.loginPage, false),
                        child: Text("Login",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Theme.of(context).primaryColor)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
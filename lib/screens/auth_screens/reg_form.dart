import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay/api/auth_services.dart';
import 'package:smart_pay/app/locator.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/constants/routes.dart';
import 'package:smart_pay/constants/spaces.dart';
import 'package:smart_pay/helpers/form_helper.dart';
import 'package:smart_pay/screens/widgets/arrow_back_container.dart';
import 'package:smart_pay/screens/widgets/loader.dart';
import '../widgets/custom_button.dart';
import '../widgets/text_form_field.dart';

class RegFormScreen extends StatefulWidget {
  final String email;
  const RegFormScreen({super.key, required this.email});

  @override
  State<RegFormScreen> createState() => _RegFormScreenState();
}

class _RegFormScreenState extends State<RegFormScreen> {
  final _router = locator<GoRouter>();
  bool isLoading = false;
  final AuthService _authService = AuthService();
  final _userName = TextEditingController();
  final _password = TextEditingController();
  final _fullName = TextEditingController();
  final _country = TextEditingController();
  bool isValidated = false;
  String countryImage = "";
  String countryName = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Form(
                  key: _formKey,
                  onChanged: () => setState(
                      () => isValidated = _formKey.currentState!.validate()),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ArrowBackContainer(),
                        SizedBox(
                          height: context.heightPercent(.04),
                        ),
                        Text(
                          "Hi there! tell us a bit",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Row(children: [
                          Text(
                            "about",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          widthSpace(5),
                          Text(
                            "yourself",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(color: AppColors.green),
                          ),
                        ]),
                        SizedBox(
                          height: context.heightPercent(.02),
                        ),
                        SmartPayTextFormField(
                          textEditingController: _fullName,
                          keyBoardType: TextInputType.name,
                          hintText: "Full name",
                          validator: stringValidation,
                        ),
                        heightSpace(16),
                        SmartPayTextFormField(
                          hintText: "Username",
                          textEditingController: _userName,
                          validator: stringValidation,
                        ),
                        heightSpace(16),
                        GestureDetector(
                          onTap: () => countryPicker(),
                          child: TextFormField(
                            controller: _country,
                            enabled: false,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                            decoration: InputDecoration(
                              prefixIcon: countryImage.isEmpty
                                  ? null
                                  : Image.asset(countryImage),
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                              hintText: "Select country",
                              fillColor: AppColors.formGrey,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: AppColors.red)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: AppColors.textFormBorderGrey)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: AppColors.red)),
                            ),
                          ),
                        ),
                        heightSpace(16),
                        SmartPayTextFormField(
                          textEditingController: _password,
                          hintText: "Password",
                          isPassword: true,
                          validator: passwordValidation,
                        ),
                        heightSpace(24),
                        SmartPayButton(
                          onTap: () async {
                            if (isValidated) {
                              setState(() {
                                isLoading = true;
                              });

                              dynamic result = await _authService.register(
                                  _fullName.text,
                                  _userName.text,
                                  "NG",
                                  widget.email,
                                  _password.text);

                              if (result) {
                                _router.push(AppRoutes.pinCode);
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          isActive: isValidated,
                          text: "Sign In",
                        ),
                        heightSpace(42.5),
                      ]),
                ),
              ),
            )),
    );
  }

  countryPicker() {
    showCountryPicker(
        context: context,
        countryListTheme: CountryListThemeData(
          flagSize: 25,
          backgroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
          bottomSheetHeight: 500, // Optional. Country list modal height
          //Optional. Sets the border radius for the bottomsheet.
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          //Optional. Styles the search field.
          inputDecoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Start typing to search',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withOpacity(0.2),
              ),
            ),
          ),
        ),
        onSelect: (Country country) {
          setState(() {
            countryImage = country.flagEmoji;
            _country.text = country.name;
          });
        }
        // print('Select country: ${country.displayName}'),

        );
  }
}
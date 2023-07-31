import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/states/adverts.dart';
import 'package:swc_front/logic/states/authentication.dart';
import 'package:swc_front/presentation/widgets/utils/ad_tag_editor.dart';
import 'package:swc_front/presentation/widgets/utils/alert_dialog_custom.dart';
import 'package:swc_front/presentation/widgets/utils/custom_button.dart';
import 'package:swc_front/presentation/widgets/utils/custom_table_widget.dart';
import 'package:swc_front/presentation/widgets/utils/description_form.dart';
import 'package:swc_front/presentation/widgets/utils/indicator_progress.dart';
import 'package:swc_front/presentation/widgets/utils/name_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/offers_plan_container.dart';
import 'package:swc_front/presentation/widgets/utils/phone_form_field.dart';
import 'package:swc_front/presentation/widgets/utils/pricing_view.dart';
import 'package:swc_front/presentation/widgets/utils/snackbar_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

import '../../data/models/advert.dart';
import '../../logic/cubits/adverts.dart';
import '../router/app_router.dart';
import '../widgets/utils/age_form_field.dart';
import '../widgets/utils/multi_file_picker_form_field.dart';

class AdvertForm extends StatefulWidget {
  const AdvertForm({super.key});

  @override
  State<AdvertForm> createState() => _AdvertForm();
}

class _AdvertForm extends State<AdvertForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  int? age;
  String? phoneNumber;
  String? description;
  List<Uint8List>? imageBytes;
  bool initialized = false;
  List<String>? ad_tags;

  @override
  void initState() {
    AuthenticationState state = context.read<AuthenticationCubit>().state;
    if (state.isLoggedIn()) {
      name = state.user!.name;
      phoneNumber = state.user!.phoneNumber;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 10),
          MultiFilePickerField(
            onChanged: (List<Uint8List>? bytes) {
              setState(() => imageBytes = bytes);
            },
          ),
          // const SizedBox(height: 10),
          NameFormField(
            onFieldSubmitted: (_) => _submitForm(),
            initialValue: name,
            onChange: (String? value, bool valid) {
              setState(() => name = valid ? value : null);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          AgeFormField(
            ageToShow: age == null ? '18 años' : '$age años',
            initialValue: age,
            onChange: (int value) {
              setState(() => age = value);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          PhoneFormField(
            onFieldSubmitted: (_) => _submitForm(),
            initialValue: phoneNumber,
            onChange: (String? value, bool valid) {
              setState(() => phoneNumber = valid ? value : null);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          AdTagEditor(
            onFieldSubmitted: (_) => _submitForm(),
            onTagsChanged: (List<String> tags) {
              setState(() => ad_tags = tags);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DescriptionFormField(
            onFieldSubmitted: (_) => _submitForm(),
            maxLines: 5,
            minLines: 1,
            maxLength: 131,
            onChange: (String? value, bool valid) {
              setState(() => description = valid ? value : null);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          _buildSubmitButton(),
          BlocConsumer<AdvertsCubit, AdvertsState>(
              listener: (BuildContext context, AdvertsState state) {
            if (state.status == AdvertsStatus.indexFailure) {
              String errorMessage = state.error;
              SnackBarUtil.showSnackBar(
                context,
                backgroundColor: const Color(0xFFFF0000),
                textColor: Colors.black,
                errorMessage,
              );
            } else if (state.status == AdvertsStatus.indexSuccess) {
              SnackBarUtil.showSnackBar(
                context,
                backgroundColor: Colors.green,
                textColor: Colors.black,
                t.createdSuccessfullAdvertLinkText,
              );
              Navigator.pushReplacementNamed(context, Routes.indexPage);
            }
          }, builder: (BuildContext context, AdvertsState state) {
            if (state.status == AdvertsStatus.loading) {
              return const CustomIndicatorProgress();
            }
            return Container();
          }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  bool _canShowSubmitButton() {
    return name != null &&
        age != null &&
        phoneNumber != null &&
        description != null &&
        description != '' &&
        imageBytes != null;
  }

  Widget _buildSubmitButton() {
    double screenWidth = MediaQuery.of(context).size.width;

    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
    return CustomButton(
      text: t.sendButtonLinkText,
      onPressed: () {
        Advert advert = _buildAdvert();
        String? token = context.read<AuthenticationCubit>().state.token;
        if (token == null) throw Exception('Token is missing');
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            hasButton: false,
            header: const Center(
              child: TextView(
                text: 'Choose your membership type',
                color: Color(0xFFFF0000),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              width: screenWidth * 0.5,
              child: PricingView(
                onTap: () =>
                    context.read<AdvertsCubit>().createAdvert(advert, token),
              ),
            ),
          ),
        );
      },
    );
  }

  // _buildPricingView(Advert advert, String token) => showDialog(
  //       context: context,
  //       builder: (context) => CustomAlertDialog(
  //         hasButton: false,
  //         header: const Center(
  //           child: TextView(
  //             text: 'Choose your membership type',
  //             color: Color(0xFFFF0000),
  //             fontSize: 25,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         content: PricingView(
  //           onTap: () =>
  //               context.read<AdvertsCubit>().createAdvert(advert, token),
  //         ),
  //       ),
  //     );

  Advert _buildAdvert() {
    return Advert(
        description: description!,
        age: age!,
        name: name!,
        phoneNumber: phoneNumber!,
        images: imageBytes!,
        ad_tags: ad_tags);
  }

  void _submitForm() {
    if (_canShowSubmitButton()) {
      Advert advert = _buildAdvert();
      String? token = context.read<AuthenticationCubit>().state.token;
      if (token == null) throw Exception('Token is missing');
      context.read<AdvertsCubit>().createAdvert(advert, token);
    }
  }
}

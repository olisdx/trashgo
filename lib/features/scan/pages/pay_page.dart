import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

import '../../../common/currency_formatter.dart';
import '../../../common/mediaquery.dart';
import '../../../common/primary_button.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../core/themes/app_font.dart';
import '../../../gen/assets.gen.dart';

@RoutePage()
class PayPage extends StatelessWidget {
  const PayPage({super.key, required this.result});

  final Barcode result;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Assets.images.reward.image(),
                    SizedBox(height: 16),
                    Text(
                      "Congratulations",
                      style: Typograph.headline24.copyWith(
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    Text(
                      "you got the reward",
                      style: Typograph.headline16.copyWith(),
                    ),
                    SizedBox(height: 24),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Assets.images.bag.image(
                        width: MQ.w(context),
                        height: 210,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Bag Gici Fucioni",
                        style: Typograph.subtitle14.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CurrencyFormatter.formattedRP(
                        360000,
                        Typograph.headline28,
                        Typograph.regular16,
                      ),
                    ),
                    SizedBox(height: 24),
                    PrimaryButton(
                      bgColor: Colors.orange,
                      text: "Get Reward",
                      onPressed: () => context.router.replaceAll([Root()]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 12),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(TablerIcons.chevron_left),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

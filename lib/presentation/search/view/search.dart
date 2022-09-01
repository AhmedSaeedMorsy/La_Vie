import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/common/widget.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SharedWidget.defaultTextFormField(
            controller: searchController,
            textInputType: TextInputType.text,
            hint: AppStrings.search,
          ),
        ]),
      ),
    );
  }
}

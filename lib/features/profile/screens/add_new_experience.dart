import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';

import '../data/models/profile_model.dart';
import 'widgets/about_widgets/custom_row_section.dart';

class AddNewExperienceScreen extends StatefulWidget {
  /// if non-null, screen is in “edit” mode
  final Experience? editing;

  const AddNewExperienceScreen({Key? key, this.editing}) : super(key: key);

  @override
  State<AddNewExperienceScreen> createState() => _AddNewExperienceScreenState();
}

class _AddNewExperienceScreenState extends State<AddNewExperienceScreen> {
  Future<void> _pickDate(BuildContext context, DateTime? initial,
      Function(DateTime) onPicked) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial ?? now,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      onPicked(picked);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.editing != null) {
      context.read<ProfileCubit>().initExperience(widget.editing!);
    } else {
      context.read<ProfileCubit>().resetForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.editing != null
              ? 'update_experience'.tr()
              : "add_experience".tr())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final cubit = context.read<ProfileCubit>();
            final dateFormat = DateFormat('yyyy-MM-dd');

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomRowSection(title: "title".tr()),
                  CustomTextField(
                    controller: cubit.titleController,
                    keyboardType: TextInputType.text,
                    hintText: 'enter_title'.tr(),
                  ),
                  const SizedBox(height: 12),
                  CustomRowSection(title: "description".tr()),
                  CustomTextField(
                    controller: cubit.descriptionController,
                    isMessage: true,
                    hintText: 'enter_description'.tr(),
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    title: Text(cubit.fromDate == null
                        ? "${'from_date'.tr()} *"
                        : "${'from'.tr()}: ${dateFormat.format(cubit.fromDate!)}"),
                    trailing: const Icon(Icons.calendar_today_outlined),
                    onTap: () =>
                        _pickDate(context, cubit.fromDate, cubit.setFromDate),
                  ),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    value: cubit.isUntilNow,
                    onChanged: (value) => cubit.toggleUntilNow(value ?? false),
                    title: CustomRowSection(title: "until_now".tr()),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    title: Text(cubit.toDate == null
                        ? (cubit.isUntilNow
                            ? "${'to'.tr()}: ${'present'.tr()}"
                            : 'to_date'.tr())
                        : "${'to'.tr()}: ${dateFormat.format(cubit.toDate!)}"),
                    trailing: const Icon(Icons.calendar_today_outlined),
                    onTap: cubit.isUntilNow
                        ? null
                        : () =>
                            _pickDate(context, cubit.toDate, cubit.setToDate),
                  ),
                  CustomButton(
                    onTap: () {
                      if (widget.editing != null) {
                        cubit.updateExperience(context,
                            id: widget.editing!.id.toString());
                      } else {
                        cubit.addNewExperience(
                          context,
                        );
                      }
                    },
                    title: "confirm".tr(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawhebtak/features/contact_us/cubit/contact_us_state.dart';
import '../data/repos/contact_us_repo.dart';


class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit(this.forgetPasswordRepo) : super(ContactUsInitial());
  ContactUsRepo forgetPasswordRepo;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController messageController = TextEditingController();
}

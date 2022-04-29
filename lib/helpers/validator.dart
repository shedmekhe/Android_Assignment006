import 'package:form_field_validator/form_field_validator.dart';

final userNameValidator =
    MultiValidator([RequiredValidator(errorText: 'Username is required')]);

final passwordRequireValidator =
    MultiValidator([RequiredValidator(errorText: 'Password is required')]);

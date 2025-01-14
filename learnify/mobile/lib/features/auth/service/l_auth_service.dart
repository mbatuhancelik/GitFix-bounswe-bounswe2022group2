import '../../../core/base/service/base_service.dart';
import '../../../core/managers/network/models/l_response_model.dart';
import '../../../core/managers/network/models/message_response.dart';
import '../forget-password/model/send_verification_request_model.dart';
import '../login/model/login_request_model.dart';
import '../login/model/login_response_model.dart';
import '../signup/model/signup_request_model.dart';
import '../verification/model/verify_email_request_model.dart';
import '../verification/model/verify_email_response_model.dart';

/// Abstract base class for auth service, defines the required functions.
abstract class IAuthService extends BaseService {
  /// Sign ups the user.
  Future<IResponseModel<MessageResponse>> signup(SignupRequest body);

  ///Logins the user.
  Future<IResponseModel<LoginResponse>> login(LoginRequest body);

  /// Sends verification code to email
  Future<IResponseModel<MessageResponse>> sendVerification(
      SendVerificationRequest body);

  /// Sends entered code to check to verify email
  Future<IResponseModel<VerifyEmailResponse>> verifyEmail(
      VerifyEmailRequest body);
}

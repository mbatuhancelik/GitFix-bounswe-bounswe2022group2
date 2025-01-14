import '../../../../core/managers/network/models/l_response_model.dart';
import '../../../core/constants/enums/request_types.dart';
import '../../../core/managers/network/models/message_response.dart';
import '../forget-password/model/send_verification_request_model.dart';
import '../login/model/login_request_model.dart';
import '../login/model/login_response_model.dart';
import '../signup/model/signup_request_model.dart';
import '../verification/model/verify_email_request_model.dart';
import '../verification/model/verify_email_response_model.dart';
import 'l_auth_service.dart';

/// Service for network request of auth view-model.
class AuthService extends IAuthService {
  /// Factory constructor for singleton structure.
  factory AuthService() => _instance;
  AuthService._();

  static final AuthService _instance = AuthService._();

  /// Static instance getter of [AuthService].
  static AuthService get instance => _instance;

  static const String _signup = '/auth/signup';
  static const String _login = '/auth/login';
  static const String _resend = '/auth/resend';
  static const String _verify = '/auth/verifyEmail';

  @override
  Future<IResponseModel<MessageResponse>> signup(SignupRequest body) async =>
      networkManager.send<SignupRequest, MessageResponse>(
        _signup,
        parseModel: const MessageResponse(),
        type: RequestTypes.post,
        body: body,
        requireAuth: false,
      );

  @override
  Future<IResponseModel<LoginResponse>> login(LoginRequest body) async =>
      networkManager.send<LoginRequest, LoginResponse>(
        _login,
        parseModel: const LoginResponse(),
        type: RequestTypes.post,
        body: body,
        requireAuth: false,
      );

  @override
  Future<IResponseModel<MessageResponse>> sendVerification(
          SendVerificationRequest body) async =>
      networkManager.send<SendVerificationRequest, MessageResponse>(_resend,
          parseModel: const MessageResponse(),
          type: RequestTypes.post,
          body: body,
          requireAuth: false);

  @override
  Future<IResponseModel<VerifyEmailResponse>> verifyEmail(
          VerifyEmailRequest body) async =>
      networkManager.send<VerifyEmailRequest, VerifyEmailResponse>(_verify,
          parseModel: const VerifyEmailResponse(),
          type: RequestTypes.post,
          body: body,
          requireAuth: false);
}

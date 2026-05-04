# 🚀 Auth Feature Implementation Guide

## ✅ ما تم إنجازه

تم بناء **Auth Feature** كاملة باستخدام:
- ✅ **Clean Architecture** (Domain, Data, Presentation)
- ✅ **Cubit** للـ State Management
- ✅ **GetIt** للـ Service Locator (Dependency Injection)
- ✅ **Dartz** للـ Either (Error Handling)
- ✅ **Dio** للـ HTTP Requests

---

## 📁 البنية الكاملة

```
lib/feature/auth/
├── domain/
│   ├── entities/
│   │   ├── user_entity.dart
│   │   └── auth_response_entity.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
│       ├── login_usecase.dart
│       └── register_usecase.dart
├── data/
│   ├── models/
│   │   ├── user_model.dart
│   │   └── auth_response_model.dart
│   ├── datasources/
│   │   └── auth_remote_datasource.dart
│   └── repositories/
│       └── auth_repository_impl.dart
└── presentation/
    ├── cubit/
    │   ├── auth_cubit.dart
    │   └── auth_state.dart
    ├── screens/
    │   ├── login_screen.dart
    │   ├── register_screen.dart
    │   ├── login_page.dart
    │   └── register_page.dart
    └── widgets/
        ├── login_form.dart
        └── register_form.dart
```

---

## 🔧 كيفية الاستخدام

### 1. في الـ Screens - إرسال Events

```dart
// للـ Login
context.read<AuthCubit>().login(
  email: 'user@example.com',
  password: 'password123',
);

// للـ Register
context.read<AuthCubit>().register(
  username: 'username',
  email: 'user@example.com',
  password: 'password123',
  role: 'Patient', // أو 'Doctor' أو 'Supervisor'
);
```

### 2. الاستماع إلى التغييرات

```dart
BlocListener<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is AuthSuccess) {
      // حفظ الـ token
      // الانتقال للـ home screen
      print('User: ${state.authResponse.user.username}');
      print('Token: ${state.authResponse.accessToken}');
    } else if (state is AuthFailure) {
      // إظهار رسالة خطأ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  child: YourWidget(),
)
```

### 3. بناء UI على الحالة

```dart
BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    if (state is AuthLoading) {
      return CircularProgressIndicator();
    }
    if (state is AuthSuccess) {
      return Text('مرحباً ${state.authResponse.user.username}');
    }
    if (state is AuthFailure) {
      return Text('خطأ: ${state.message}');
    }
    return LoginForm();
  },
)
```

---

## 🌐 API Endpoints

### Base URL: `http://murafik.runasp.net/api/auth`

#### 1. Register
```
POST /register
Content-Type: application/json

{
  "username": "string",
  "email": "string",
  "password": "string",
  "role": "Patient" | "Doctor" | "Supervisor"
}
```

#### 2. Login
```
POST /login
Content-Type: application/json

{
  "email": "string",
  "password": "string"
}
```

---

## 📊 States الـ Cubit

### 1. AuthInitial
- الحالة الأولية للتطبيق
- لا توجد بيانات مستخدم

### 2. AuthLoading
- يتم معالجة الطلب
- يمكن إظهار مؤشر التحميل

### 3. AuthSuccess
```dart
class AuthSuccess extends AuthState {
  final AuthResponseEntity authResponse;
  
  // الخصائص:
  // authResponse.success (bool)
  // authResponse.message (String)
  // authResponse.accessToken (String?)
  // authResponse.expiresAt (DateTime)
  // authResponse.user.id, username, email, role, etc.
}
```

### 4. AuthFailure
```dart
class AuthFailure extends AuthState {
  final String message;
  // رسالة الخطأ من السيرفر أو المحتوى المحلي
}
```

---

## 🛠️ الخطوات التالية

### 1. **حفظ الـ Token** (مهم جداً)
```dart
// أضف `shared_preferences` إلى pubspec.yaml
// shared_preferences: ^2.2.2

// أنشئ Token Service
class TokenService {
  static const String _tokenKey = 'access_token';
  static const String _expiryKey = 'token_expiry';
  
  Future<void> saveToken(String token, DateTime expiresAt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_expiryKey, expiresAt.toIso8601String());
  }
  
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
  
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_expiryKey);
  }
}
```

### 2. **حفظ البيانات في AuthSuccess**
```dart
// في BlocListener
if (state is AuthSuccess) {
  // احفظ الـ token
  await tokenService.saveToken(
    state.authResponse.accessToken ?? '',
    state.authResponse.expiresAt,
  );
  
  // احفظ بيانات المستخدم (اختياري)
  // الانتقل إلى الصفحة المناسبة حسب الدور
  switch (state.authResponse.user.role) {
    case 'Patient':
      context.go('/PatientHome');
      break;
    case 'Doctor':
      context.go('/DoctorHome');
      break;
    case 'Supervisor':
      context.go('/SupervisorHome');
      break;
  }
}
```

### 3. **Dio Interceptor** (لإضافة Token إلى الطلبات)
```dart
// في service_locator.dart
dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await tokenService.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
    onError: (error, handler) async {
      // إذا كان الـ token منتهياً (401)
      if (error.response?.statusCode == 401) {
        // قم بـ logout
        // أعد التوجيه إلى login
      }
      return handler.next(error);
    },
  ),
);
```

### 4. **Splash Screen Logic**
```dart
// في Splash Screen Cubit
Future<void> checkAuth() async {
  final token = await tokenService.getToken();
  
  if (token != null) {
    // يوجد token محفوظ - ذهب إلى home
    // يمكنك هنا عمل auto-login
    _onNavigation(NavigateToHome());
  } else {
    // لا يوجد token - اذهب إلى login
    _onNavigation(NavigateToLogin());
  }
}
```

### 5. **Logout Functionality**
```dart
// في AuthCubit
Future<void> logout() async {
  // حذف الـ token
  await tokenService.clearToken();
  
  // حذف البيانات الأخرى إن وجدت
  
  // عد إلى الحالة الأولية
  emit(const AuthInitial());
  
  // الانتقال إلى login page
  // context.go('/login');
}
```

---

## 🧪 الاختبار

### 1. بيانات اختبار من الـ API:

**User 1 - Supervisor:**
```
Email: sara@test.com
Password: (check with backend)
Role: Supervisor
```

**User 2 - Patient:**
```
Email: ahmed1234@test.com
Password: (check with backend)
Role: Patient
```

### 2. محاكاة الـ API

```dart
// إذا كان الـ backend غير متاح، استخدم Mockito:

class MockAuthDataSource extends Mock implements AuthRemoteDataSource {
  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    return AuthResponseModel(
      success: true,
      message: 'Login successful',
      accessToken: 'mock_token_123',
      expiresAt: DateTime.now().add(Duration(hours: 24)),
      user: UserModel(
        id: 1,
        username: 'Test User',
        email: email,
        role: 'Patient',
      ),
    );
  }
}
```

---

## ⚠️ ملاحظات مهمة

1. **الـ API Base URL**: `http://murafik.runasp.net/api/auth`
   - تأكد من توفر الـ backend قبل الاختبار

2. **CORS**: إذا كنت تختبر من الويب، تأكد من تفعيل CORS على السيرفر

3. **Security**:
   - لا تخزن الـ password بشكل مباشر
   - استخدم HTTPS في الإنتاج
   - أضف encryption للـ token المحفوظ (مثل flutter_secure_storage)

4. **Token Expiry**:
   - تحقق من انتهاء الـ token قبل استخدامه
   - قم بـ refresh token إذا لزم الأمر

---

## 📚 المراجع

- [Flutter BLoC Documentation](https://bloclibrary.dev/)
- [Clean Architecture Guide](https://resocoder.com/flutter-clean-architecture)
- [Dartz Either Usage](https://pub.dev/packages/dartz)
- [Dio HTTP Client](https://pub.dev/packages/dio)

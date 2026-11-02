import '../models/language_model.dart';

class LanguageRepository {
  List<LanguageModel> getLanguages() => const [
    LanguageModel(code: 'en', name: 'English', greeting: 'Hi'),
    LanguageModel(code: 'hi', name: 'Hindi', greeting: 'नमस्ते'),
    LanguageModel(code: 'bn', name: 'Bengali', greeting: 'হ্যালো'),
    LanguageModel(code: 'kn', name: 'Kannada', greeting: 'ನಮಸ್ಕಾರ'),
    LanguageModel(code: 'pa', name: 'Punjabi', greeting: 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ'),
    LanguageModel(code: 'ta', name: 'Tamil', greeting: 'வணக்கம்'),
    LanguageModel(code: 'te', name: 'Telugu', greeting: 'హలో'),
    LanguageModel(code: 'fr', name: 'French', greeting: 'Bonjour'),
    LanguageModel(code: 'es', name: 'Spanish', greeting: 'Hola'),
  ];
}

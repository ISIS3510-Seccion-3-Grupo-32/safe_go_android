library my_prj.globals;

bool isDarkMode = false;

void setDarkMode(bool mode) {
  isDarkMode = mode;
}

bool isNotificationOn = false;

void setNotification(bool notif) {
  isNotificationOn = notif;
}

double sound = 0;

void setSound(double value) {
  sound = value;
}

String language = 'en';

void setLanguage(String lang) {
  language = lang;
}

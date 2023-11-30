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

enum Languages { english, spanish, french }

void setSound(double value) {
  sound = value;
}

Languages language = Languages.english;

void setLanguage(String lang) {
  switch (lang) {
    case "en":
      language = Languages.english;
      break;
    case "es":
      language = Languages.spanish;
      break;
    case "fr":
      language = Languages.french;
      break;
  }
}

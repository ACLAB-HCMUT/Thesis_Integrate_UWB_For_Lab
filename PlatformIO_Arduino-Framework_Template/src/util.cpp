#include "util.h"

void extract_data() {
  for (int i = 0; i < 4; i++) {
    String tagInfo = "an" + String(i + 1) + ":";
    int startIndex = DATA.indexOf(tagInfo);

    int endIndex = DATA.indexOf("m", startIndex);
    String distance = DATA.substring(startIndex + tagInfo.length(), endIndex);
    if (startIndex == -1 || endIndex == -1)
      distance = "0";
    values[i] = distance;
  }
}

void writeToCSV() {
  extract_data();
  String data = values[3];

  // Mở (hoặc tạo) tệp "data.csv" để ghi
  File file = SPIFFS.open("/data.csv", FILE_WRITE);
  if (!file) {
    Serial.println("Failed to open file for writing");
    return;
  }

  // Ghi chuỗi vào tệp và xuống dòng
  Serial.print(data.c_str());
  file.println(data.c_str());
  file.close(); // Đóng tệp sau khi ghi xong

  Serial.println("Data written to CSV file.");
}
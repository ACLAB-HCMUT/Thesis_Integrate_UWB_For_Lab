#include "util.h"

void extract_data() {
  for (int i = 0; i < 4; i++) {
    String anchor_info = "an" + String(i + 1) + ":";
    int start_index = data_uwb.indexOf(anchor_info);
    int end_index = data_uwb.indexOf("m", start_index);

    String distance_str;
    if (start_index != -1 && end_index != -1) {
      distance_str = data_uwb.substring(start_index + anchor_info.length(), end_index);
    } else {
      distance_str = "0";
    }

    float distance = distance_str.toFloat();
    if (distance < 0) {
      distance = 0;
    }
    value_uwb[i] = distance;
  }
}
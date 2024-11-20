#include "util.h"

float modify_distance(float dis) {
  return (dis - intercept) / slope;
}
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
    distance_uwb[i] = modify_distance(distance);
  }
}

void calc_position() {
  Serial.println(data_uwb);
  if (data_uwb.isEmpty()) {
    Serial.println("No data available for position calculation.");
    return;
  }

  extract_data();
  float R_1 = distance_uwb[0];
  float R_21 = distance_uwb[1] - distance_uwb[0];
  float R_31 = distance_uwb[2] - distance_uwb[0];
  float R_41 = distance_uwb[3] - distance_uwb[0];

  float k_1 = pow(anchor_1.x, 2) + pow(anchor_1.y, 2) + pow(anchor_1.z, 2);
  float k_2 = pow(anchor_2.x, 2) + pow(anchor_2.y, 2) + pow(anchor_2.z, 2);
  float k_3 = pow(anchor_3.x, 2) + pow(anchor_3.y, 2) + pow(anchor_3.z, 2);
  float k_4 = pow(anchor_4.x, 2) + pow(anchor_4.y, 2) + pow(anchor_4.z, 2);

  Eigen::Matrix3f A;
  A << anchor_2.x - anchor_1.x, anchor_2.y - anchor_1.y, anchor_2.z - anchor_1.z,
      anchor_3.x - anchor_1.x, anchor_3.y - anchor_1.y, anchor_3.z - anchor_1.z,
      anchor_4.x - anchor_1.x, anchor_4.y - anchor_1.y, anchor_4.z - anchor_1.z;

  Eigen::Vector3f B, X;
  B << -(R_21)*R_1 + 0.5 * (k_2 - k_1 - pow(R_21, 2)),
      -(R_31)*R_1 + 0.5 * (k_3 - k_1 - pow(R_31, 2)),
      -(R_41)*R_1 + 0.5 * (k_4 - k_1 - pow(R_41, 2));

  // Solve AX=B
  Eigen::ColPivHouseholderQR<Eigen::Matrix3f> dec(A);
  if (dec.isInvertible()) {
    X = dec.solve(B);
    for (int i = 0; i < 3; i++) {
      position_uwb[i] = X(i);
    }
  }
}

void display_extractdata() {
  Serial.println("Real distances:");
  for (int i = 0; i < 4; i++) {
    Serial.println(distance_uwb[i]);
  }

  Serial.println("Real position:");
  for (int i = 0; i < 3; i++) {
    Serial.println(position_uwb[i]);
  }
}
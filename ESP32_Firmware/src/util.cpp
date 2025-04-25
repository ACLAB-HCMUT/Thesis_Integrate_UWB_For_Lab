/*
#include "util.h"

////TEST////
// #define N_ANCHORS 4
// float g_anchor_matrix[N_ANCHORS][3] = {
//     // list of anchor coordinates, relative to chosen origin.
//     {0.0, 0.0, 0.0},  // Anchor labeled #1
//     {0.0, 0.46, 0.0}, // Anchor labeled #2
//     {1.15, 0.0, 0.0}, // Anchor labeled #3
//     {1.15, 0.46, 0.0} // Anchor labeled #4
// };
// float g_current_distance_rmse = 0.0; // rms error in distance calc => crude measure of position error (meters).  Needs to be better characterized

float modify_distance(float dis) {
  return (dis - g_intercept) / g_slope;
}
void extract_data() {
  for (int i = 0; i < 4; i++) {
    String anchor_info = "an" + String(i + 1) + ":";
    int start_index = g_data_uwb.indexOf(anchor_info);
    int end_index = g_data_uwb.indexOf("m", start_index);

    String distance_str;
    if (start_index != -1 && end_index != -1) {
      distance_str = g_data_uwb.substring(start_index + anchor_info.length(), end_index);
    } else {
      distance_str = "0";
    }

    float distance = distance_str.toFloat();
    if (distance < 0) {
      distance = 0;
    }
    // g_distance_uwb[i] = modify_distance(distance) > 0 ? modify_distance(distance) : 0;
    g_distance_uwb[i] = distance;
  }
}

// void calc_position() {
//   return;
//   Serial.println(g_data_uwb);
//   if (g_data_uwb.isEmpty()) {
//     Serial.println("No data available for position calculation.");
//     return;
//   }

//   extract_data();
//   float R_1 = g_distance_uwb[0];
//   float R_21 = g_distance_uwb[1] - g_distance_uwb[0];
//   float R_31 = g_distance_uwb[2] - g_distance_uwb[0];
//   float R_41 = g_distance_uwb[3] - g_distance_uwb[0];

//   float k_1 = pow(anchor_1.x, 2) + pow(anchor_1.y, 2) + pow(anchor_1.z, 2);
//   float k_2 = pow(anchor_2.x, 2) + pow(anchor_2.y, 2) + pow(anchor_2.z, 2);
//   float k_3 = pow(anchor_3.x, 2) + pow(anchor_3.y, 2) + pow(anchor_3.z, 2);
//   float k_4 = pow(anchor_4.x, 2) + pow(anchor_4.y, 2) + pow(anchor_4.z, 2);

//   Eigen::Matrix3f A;
//   A << anchor_2.x - anchor_1.x, anchor_2.y - anchor_1.y, anchor_2.z - anchor_1.z,
//       anchor_3.x - anchor_1.x, anchor_3.y - anchor_1.y, anchor_3.z - anchor_1.z,
//       anchor_4.x - anchor_1.x, anchor_4.y - anchor_1.y, anchor_4.z - anchor_1.z;

//   Eigen::Vector3f B, X;
//   B << -(R_21)*R_1 + 0.5 * (k_2 - k_1 - pow(R_21, 2)),
//       -(R_31)*R_1 + 0.5 * (k_3 - k_1 - pow(R_31, 2)),
//       -(R_41)*R_1 + 0.5 * (k_4 - k_1 - pow(R_41, 2));

//   // Solve AX=B
//   Eigen::ColPivHouseholderQR<Eigen::Matrix3f> dec(A);
//   if (dec.isInvertible()) {
//     X = dec.solve(B);
//     for (int i = 0; i < 3; i++) {
//       g_position_uwb[i] = X(i);
//     }
//   }
// }

void display_extractdata() {
  Serial.println("Real distances:");
  for (int i = 0; i < 4; i++) {
    Serial.println(g_distance_uwb[i]);
  }

  Serial.println("Real position:");
  for (int i = 0; i < 2; i++) {
    Serial.println(g_position_uwb[i]);
  }

  Serial.print("RMS: ");
  Serial.println(g_current_distance_rmse);
}

void calc_position() {
  if (g_data_uwb.isEmpty()) {
    Serial.println("No data available for position calculation.");
    return;
  }
  extract_data();
  float d[N_ANCHORS];
  float x[N_ANCHORS], y[N_ANCHORS]; // intermediate vectors
  float A[N_ANCHORS - 1][2], Ainv[2][2], b[N_ANCHORS - 1], kv[N_ANCHORS];

  int i, j, k;
  for (i = 0; i < N_ANCHORS; i++)
    d[i] = g_distance_uwb[i];
  for (i = 0; i < N_ANCHORS; i++) {
    x[i] = g_anchor_matrix[i][0];
    y[i] = g_anchor_matrix[i][1];
    kv[i] = x[i] * x[i] + y[i] * y[i];
  }
  for (i = 1; i < N_ANCHORS; i++) {
    A[i - 1][0] = x[i] - x[0];
    A[i - 1][1] = y[i] - y[0];
  }

  float ATA[2][2]; // calculate A transpose A
  // Cij = sum(k) (Aki*Akj)
  for (i = 0; i < 2; i++) {
    for (j = 0; j < 2; j++) {
      ATA[i][j] = 0.0;
      for (k = 0; k < N_ANCHORS - 1; k++)
        ATA[i][j] += A[k][i] * A[k][j];
    }
  }
  float det = ATA[0][0] * ATA[1][1] - ATA[1][0] * ATA[0][1];
  if (fabs(det) < 1.0E-4) {
    Serial.println("***Singular matrix, check anchor coordinates***");
    while (1)
      vTaskDelay(pdMS_TO_TICKS(1));
  }

  det = 1.0 / det;
  Ainv[0][0] = det * ATA[1][1];
  Ainv[0][1] = -det * ATA[0][1];
  Ainv[1][0] = -det * ATA[1][0];
  Ainv[1][1] = det * ATA[0][0];

  for (i = 1; i < N_ANCHORS; i++) {
    b[i - 1] = d[0] * d[0] - d[i] * d[i] + kv[i] - kv[0];
  }

  float ATb[2] = {0.0}; // A transpose b
  for (i = 0; i < N_ANCHORS - 1; i++) {
    ATb[0] += A[i][0] * b[i];
    ATb[1] += A[i][1] * b[i];
  }

  g_position_uwb[0] = 0.5 * (Ainv[0][0] * ATb[0] + Ainv[0][1] * ATb[1]);
  g_position_uwb[1] = 0.5 * (Ainv[1][0] * ATb[0] + Ainv[1][1] * ATb[1]);

  float rmse = 0.0, dc0 = 0.0, dc1 = 0.0, dc2 = 0.0;
  for (i = 0; i < N_ANCHORS; i++) {
    dc0 = g_position_uwb[0] - g_anchor_matrix[i][0];
    dc1 = g_position_uwb[1] - g_anchor_matrix[i][1];
    dc2 = g_anchor_matrix[i][2]; // include known Z coordinate of anchor
    dc0 = d[i] - sqrt(dc0 * dc0 + dc1 * dc1 + dc2 * dc2);
    rmse += dc0 * dc0;
  }
  g_current_distance_rmse = sqrt(rmse / ((float)N_ANCHORS));
}

void display_single(int anchor_id) {
  Serial.println(g_distance_uwb[anchor_id]);
  vTaskDelay(pdMS_TO_TICKS(250));
}
  */
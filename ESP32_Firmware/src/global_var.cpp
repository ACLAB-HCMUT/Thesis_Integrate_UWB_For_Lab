#include "global_var.h"

// Define variables for LED
const int g_LED_PIN = 27; // Set LED GPIO
String g_led_state;       // Stores LED state

// Define variables for UWB
char g_tag_id[] = "1";                                            // Tag ID
char g_room_id[] = "B3-301";                                      // Room ID
String g_data_uwb = "an1:1.98m\nan2:1.71m\nan3:2.54m\nan4:2.82m"; // Raw UWB distance data received
float g_distance_uwb[N_ANCHORS] = {0, 0, 0, 0};                   // Stores the distance to each anchor
float g_position_uwb[N_DIMENSIONS] = {0.0, 0.0, 0.0};             // Stores position of tag
float g_slope = 1.1338989898989882;                               // a in y = a*x + b
float g_intercept = 0.117644444444446;                            // b in y = a*x + b

float g_anchor_matrix[N_ANCHORS][N_DIMENSIONS] = {
    {0.0, 0.0, 0.0},
    {0.0, 0.55, 0.0},
    {1.45, 0.0, 0.0},
    {1.45, 0.55, 0.0}};
float g_current_distance_rmse = 0.0;
-- USER table
CREATE TABLE "user" (
  user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  email VARCHAR(255),
  password VARCHAR(255),
  full_name VARCHAR(255),
  phone_number VARCHAR(20),
  role VARCHAR(50),
  status VARCHAR(50)
);

-- ROOM table
CREATE TABLE room (
  room_id SERIAL PRIMARY KEY,
  room_max_x FLOAT,
  room_max_y FLOAT
);

-- DEVICE_TYPE table
CREATE TABLE device_type (
  type_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  type_name VARCHAR(100)
);

-- DEVICE table
CREATE TABLE device (
  device_id SERIAL PRIMARY KEY,
  device_name VARCHAR(255),
  description TEXT,
  serial VARCHAR(255),
  manufacturer VARCHAR(255),
  specification TEXT,
  type_id INT REFERENCES device_type(type_id),
  image TEXT,
  is_active BOOLEAN,
  is_available BOOLEAN
);

-- BORROW_REQUEST table
CREATE TABLE borrow_request (
  request_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  device_id INT REFERENCES device(device_id),
  detail TEXT,
  status VARCHAR(50),
  appointment_date TIMESTAMP,
  expected_return TIMESTAMP,
  borrow_date TIMESTAMP,
  return_date TIMESTAMP,
  client_id INT REFERENCES "user"(user_id)
);

-- ANCHOR_LOCATION table
CREATE TABLE anchor_location (
  anchorrec_id SERIAL PRIMARY KEY,
  anchor_id INT,
  anchor_x FLOAT,
  anchor_y FLOAT,
  anchor_z FLOAT,
  record_time TIMESTAMP,
  room_id INT REFERENCES room(room_id)
);

-- DEVICE_LOCATION table
CREATE TABLE device_location (
  devicerec_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  device_id INT REFERENCES device(device_id),
  tag_x FLOAT,
  tag_y FLOAT,
  tag_z FLOAT,
  room_id INT REFERENCES room(room_id),
  record_time TIMESTAMP,
  record_type VARCHAR(50)
);

-- NOTIFICATION table
CREATE TABLE notification (
  notify_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  description TEXT,
  notify_time TIMESTAMP,
  type VARCHAR(50),
  is_read BOOLEAN,
  user_id INT REFERENCES "user"(user_id)
);

-- MQTT_MESSAGES table
CREATE TABLE mqtt_messages (
    id SERIAL PRIMARY KEY,
    topic VARCHAR(255),
    message TEXT,
    received_at TIMESTAMP WITHOUT TIME ZONE
);
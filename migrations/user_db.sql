CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    user_code uuid not null unique,
    first_name VARCHAR (127) NOT NULL,
    surname VARCHAR (127) NOT NULL,
    email VARCHAR (255) NOT NULL,
    phone VARCHAR (50),
    password VARCHAR (127) NOT NULL, //bcrypt
    created_at TIMESTAMP NOT NULL default now(),
    updated_at TIMESTAMP NOT NULL default now()
);

CREATE unique index email_idx ON users (email);
CREATE INDEX user_id_idx ON users (user_id);

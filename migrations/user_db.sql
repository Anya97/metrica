CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    user_id uuid not null,
    first_name VARCHAR (127) NOT NULL,
    surname VARCHAR (127) NOT NULL,
    email VARCHAR (255) UNIQUE NOT NULL,
    phone VARCHAR (50),
    password VARCHAR (255) NOT NULL,
    created_at TIMESTAMP NOT NULL default now(),
    updated_at TIMESTAMP NOT NULL default now()
);

CREATE INDEX email_idx ON users (email);
CREATE INDEX user_id_idx ON users (user_id);

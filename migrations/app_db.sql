CREATE TABLE apps (
    id SERIAL PRIMARY KEY,
    app_id  uuid not null,
    user_id uuid not null,
    app_name VARCHAR (255) NOT NULL,
    app_token VARCHAR (255) NOT NULL,
    created_at TIMESTAMP NOT NULL default now(),
    updated_at TIMESTAMP NOT NULL default now()
);

CREATE INDEX app_id_idx ON apps (app_id);
CREATE INDEX user_id_idx ON apps (user_id);

CREATE TABLE events (
     id SERIAL PRIMARY KEY,
     app_id uuid references apps(id),
     name VARCHAR (255) NOT NULL,
     type VARCHAR (50) NOT NULL,
     created_at TIMESTAMP NOT NULL default now(),
     updated_at TIMESTAMP NOT NULL default now()
);

CREATE INDEX app_id_idx ON events (app_id);

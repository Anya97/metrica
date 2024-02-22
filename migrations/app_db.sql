CREATE TABLE apps (
    id SERIAL PRIMARY KEY,
    app_code uuid not null,
    user_code uuid not null unique,
    app_name VARCHAR (255) NOT NULL,
    app_token VARCHAR (255) NOT NULL,
    created_at TIMESTAMP NOT NULL default now(),
    updated_at TIMESTAMP NOT NULL default now()
);

CREATE INDEX app_id_idx ON apps (app_code);
CREATE INDEX user_id_idx ON apps (user_code);
CREATE INDEX app_token_idx ON apps (app_token);


CREATE TABLE events (
     id SERIAL PRIMARY KEY,
     app_code uuid references apps(app_code),
     event_code uuid not null,
     name VARCHAR (255) NOT NULL,
     description text,
     args jsonb NOT NULL,
     created_at TIMESTAMP NOT NULL default now(),
     updated_at TIMESTAMP NOT NULL default now()
);

CREATE INDEX app_id_idx ON events (app_code);
CREATE INDEX name_idx ON events (name);
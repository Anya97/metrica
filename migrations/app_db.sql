CREATE TABLE apps (
    id SERIAL PRIMARY KEY,
    app_code uuid not null,
    user_code uuid not null unique,
    app_name VARCHAR (255) NOT NULL,
    app_token VARCHAR (255) NOT NULL,
    created_at TIMESTAMP NOT NULL default now(),
    updated_at TIMESTAMP NOT NULL default now()
);

CREATE INDEX apps_app_id_idx ON apps (app_code);
CREATE INDEX apps_user_id_idx ON apps (user_code);
CREATE INDEX apps_app_token_idx ON apps (app_token);


CREATE TABLE events (
     id BIGSERIAL PRIMARY KEY,
     app_code uuid references apps(app_code),
     event_code uuid not null,
     name VARCHAR (255) NOT NULL,
     args jsonb NOT NULL,
     created_at TIMESTAMP NOT NULL default now(),
     updated_at TIMESTAMP NOT NULL default now()
);

CREATE INDEX events_app_code_name_idx ON events (app_code, name);
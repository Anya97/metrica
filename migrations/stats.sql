CREATE TABLE IF NOT EXISTS stats (
    event_date DateTime DEFAULT now(),
    app_name VARCHAR(255),
    event_name VARCHAR(255),
    keys Array(VARCHAR(127)),
    vals Array(VARCHAR(127))
    )
    ENGINE = MergeTree()

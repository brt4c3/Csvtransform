\c postgres;

-- Create the table for the form
CREATE TABLE IF NOT EXISTS "テスト" (
    ID SERIAL PRIMARY KEY,
    Age VARCHAR(255),
    Name VARCHAR(255),
    City VARCHAR(255)
);


DROP TABLE IF EXISTS bounties;
CREATE TABLE bounties(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  bounty_value INT,
  homeworld VARCHAR(255),
  favourite_weapon VARCHAR(255)
);

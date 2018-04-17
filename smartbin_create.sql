-- fix default encoding (in case you want, like, emojis)
ALTER DATABASE smartbin
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS Users (
  id INT NOT NULL AUTO_INCREMENT,
  can VARCHAR(16) UNIQUE NOT NULL, -- auto index
--  name VARCHAR(30)
--    NOT NULL,
  display_name VARCHAR(50)
    NOT NULL,
  phone_number VARCHAR(10),
  active BOOL NOT NULL,
  PRIMARY KEY (id)
);-- DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS Items (
  id INT NOT NULL AUTO_INCREMENT,
  score INT NOT NULL,
  mass INT NOT NULL, -- in grams
  category SMALLINT NOT NULL,
  deposited_by INT NOT NULL,
  created_at DATETIME NOT NULL,
  extra_info JSON,
  PRIMARY KEY (id),
  INDEX idx_deposited_by_1 (deposited_by),
  FOREIGN KEY (deposited_by)
    REFERENCES Users (id)
    ON DELETE RESTRICT
) DEFAULT CHARSET = utf8mb4;

-- to migrate the db to include creation time column do this:
-- ALTER TABLE Items ADD COLUMN created_at DATETIME NOT NULL;

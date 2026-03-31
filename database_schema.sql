-- Create EXTRA table
CREATE TABLE EXTRA (
    ExtraID INT PRIMARY KEY NOT NULL,
    ExtraDescription VARCHAR(20) NOT NULL
);

-- Create HOUSE_EXTRA table with relationships
CREATE TABLE HOUSE_EXTRA (
    HouseID INT NOT NULL,
    ExtraID INT NOT NULL,
    PRIMARY KEY (HouseID, ExtraID),
    FOREIGN KEY (HouseID) REFERENCES HOUSE(HouseID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ExtraID) REFERENCES EXTRA(ExtraID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create ACTIVE_OWNER table
CREATE TABLE ACTIVE_OWNER (
    OwnerID INT NOT NULL,
    OwnerFirstName VARCHAR(60) NOT NULL,
    OwnerLastName VARCHAR(60) NOT NULL,
    OwnerStatus BOOL DEFAULT TRUE,
    OwnerEmail VARCHAR(80) NOT NULL
);

-- Populate ACTIVE_OWNER with active owners
INSERT INTO ACTIVE_OWNER
SELECT OwnerID, OwnerFirstName, OwnerLastName, OwnerEmail
FROM OWNER
WHERE OwnerEndDate IS NULL;

-- Create index for faster searches
CREATE INDEX NameSearch ON ACTIVE_OWNER(OwnerFirstName, OwnerLastName);

-- Add unique constraint
ALTER TABLE ACTIVE_OWNER
ADD CONSTRAINT DuplicateCheck UNIQUE (OwnerFirstName, OwnerLastName, OwnerEmail);

-- Modify EXTRA table
ALTER TABLE EXTRA
ADD COLUMN ExtraPrice FLOAT;

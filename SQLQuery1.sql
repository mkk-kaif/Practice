CREATE DATABASE LSBU_SMART_HOME01;
GO

USE LSBU_SMART_HOME01;
GO

-- Client Table
CREATE TABLE Client (
    ClientID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(255)
);

-- Building Table
CREATE TABLE Building (
    BuildingID INT PRIMARY KEY,
    Address VARCHAR(255) NOT NULL,
    Type VARCHAR(50)
);

-- Ownership (Junction Table)
CREATE TABLE Ownership (
    ClientID INT,
    BuildingID INT,
    PRIMARY KEY (ClientID, BuildingID),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (BuildingID) REFERENCES Building(BuildingID)
);

-- Supplier Table
CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    ContactDetails VARCHAR(255)
);

-- IoTDevice Table
CREATE TABLE IoTDevice (
    DeviceID INT PRIMARY KEY,
    Type VARCHAR(100) NOT NULL,
    Model VARCHAR(100) NOT NULL,
    Manufacturer VARCHAR(100),
    CompatibilityInfo VARCHAR(255),
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

-- SpecialistEquipment Table
CREATE TABLE SpecialistEquipment (
    EquipmentID INT PRIMARY KEY,
    Type VARCHAR(100) NOT NULL,
    Model VARCHAR(100),
    Features TEXT
);

-- Design Table
CREATE TABLE Design (
    DesignID INT PRIMARY KEY,
    DateCreated DATE NOT NULL,
    Description TEXT
);

-- DesignDevice (Junction Table)
CREATE TABLE DesignDevice (
    DesignID INT,
    DeviceID INT,
    EquipmentID INT,
    PRIMARY KEY (DesignID, DeviceID, EquipmentID),
    FOREIGN KEY (DesignID) REFERENCES Design(DesignID),
    FOREIGN KEY (DeviceID) REFERENCES IoTDevice(DeviceID),
    FOREIGN KEY (EquipmentID) REFERENCES SpecialistEquipment(EquipmentID)
);

-- Team Table
CREATE TABLE Team (
    TeamID INT PRIMARY KEY,
    TeamName VARCHAR(100)
);

-- Staff Table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Expertise VARCHAR(100),
    Phone VARCHAR(20)
);

-- StaffTeam (Junction Table)
CREATE TABLE StaffTeam (
    StaffID INT,
    TeamID INT,
    PRIMARY KEY (StaffID, TeamID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

-- Installation Table
CREATE TABLE Installation (
    InstallationID INT PRIMARY KEY,
    BuildingID INT,
    DesignID INT,
    TeamID INT,
    InstallDate DATE NOT NULL,
    FOREIGN KEY (BuildingID) REFERENCES Building(BuildingID),
    FOREIGN KEY (DesignID) REFERENCES Design(DesignID),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

-- DeviceInstallation (Junction Table)
CREATE TABLE DeviceInstallation (
    InstallationID INT,
    DeviceID INT,
    StaffID INT,
    InstallTimestamp DATETIME,
    PRIMARY KEY (InstallationID, DeviceID, StaffID),
    FOREIGN KEY (InstallationID) REFERENCES Installation(InstallationID),
    FOREIGN KEY (DeviceID) REFERENCES IoTDevice(DeviceID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);


-- Controller Table
CREATE TABLE Controller (
    ControllerID INT PRIMARY KEY,
    Protocol VARCHAR(50) NOT NULL,
    Location VARCHAR(100),
    BuildingID INT,
    FOREIGN KEY (BuildingID) REFERENCES Building(BuildingID)
);

-- SensorData Table
CREATE TABLE SensorData (
    DataID INT PRIMARY KEY,
    ControllerID INT,
    SensorID INT,
    ReadingValue VARCHAR(100),
    ReadingTimestamp DATETIME,
    FOREIGN KEY (ControllerID) REFERENCES Controller(ControllerID),
    FOREIGN KEY (SensorID) REFERENCES IoTDevice(DeviceID)
);

-- Invoice Table
CREATE TABLE Invoice (
    InvoiceID INT PRIMARY KEY,
    ClientID INT,
    DateIssued DATE NOT NULL,
    Amount DECIMAL(10,2),
    Status VARCHAR(50),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
);

-- Payment Table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    InvoiceID INT,
    Method VARCHAR(50),
    DatePaid DATE,
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID)
-- Recipt Table 
CREATE TABLE Recipt
    PaymentID INT PRIMARY KEY,
    InvoiceID INT,
    Method VARCHAR(50),
    DatePaid DATE,
    Status DatePaid,
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID)
);

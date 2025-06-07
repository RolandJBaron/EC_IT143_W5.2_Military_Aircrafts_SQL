DROP TABLE IF EXISTS dbo.military_aircraft;
CREATE TABLE dbo.military_aircraft (
    Name VARCHAR(100),
    Country VARCHAR(100),
    Role VARCHAR(50),
    First_Flight VARCHAR(10),
    Status VARCHAR(50)
);

INSERT INTO dbo.military_aircraft (Name, Country, Role, First_Flight, Status) VALUES
('F-14 Tomcat', 'USA', 'Fighter', '1970', 'Retired'),
('B-52 Stratofortress', 'USA', 'Bomber', '1952', 'Active'),
('MiG-29 Fulcrum', 'Russia', 'Fighter', '1977', 'Active'),
('Eurofighter Typhoon', 'UK/Europe', 'Multirole', '1994', 'Active'),
('SR-71 Blackbird', 'USA', 'Reconnaissance', '1964', 'Retired'),
('Mirage III', 'France', 'Interceptor', '1956', 'Retired'),
('JAS 39 Gripen', 'Sweden', 'Multirole', '1988', 'Active'),
('F-35 Lightning II', 'USA', 'Stealth Multirole', '2006', 'Active'),
('Su-57 Felon', 'Russia', 'Stealth Fighter', '2010', 'Limited Service'),
('Rafale', 'France', 'Multirole', '1986', 'Active'),
('A-10 Thunderbolt II', 'USA', 'Ground Attack', '1972', 'Active'),
('F-22 Raptor', 'USA', 'Stealth Fighter', '1997', 'Active');

-- Question 1 by Another Student:
-- What percentage of active aircraft per country are bombers, and which country has the highest bomber ratio?
SELECT Country,
       COUNT(*) AS total_aircraft,
       SUM(CASE WHEN Role = 'Bomber' THEN 1 ELSE 0 END) AS bomber_count,
       ROUND(SUM(CASE WHEN Role = 'Bomber' THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS bomber_percentage
FROM dbo.military_aircraft
WHERE Status = 'Active'
GROUP BY Country
ORDER BY bomber_percentage DESC;

-- Question 2 by Me:
-- Which countries have produced the most fighter aircraft still in active service?
SELECT Country,
       COUNT(*) AS active_fighters
FROM dbo.military_aircraft
WHERE Role = 'Fighter' AND Status = 'Active'
GROUP BY Country
ORDER BY active_fighters DESC;

-- Question 3 by Me:
-- What are the most common aircraft roles introduced after the year 2000?
SELECT Role,
       COUNT(*) AS aircraft_count
FROM dbo.military_aircraft
WHERE TRY_CAST(First_Flight AS INT) > 2000
GROUP BY Role
ORDER BY aircraft_count DESC;

-- Question 4 by Me:
-- How many aircraft were introduced per decade by country?
SELECT Country,
       (TRY_CAST(First_Flight AS INT) / 10) * 10 AS Decade,
       COUNT(*) AS aircraft_count
FROM dbo.military_aircraft
GROUP BY Country, (TRY_CAST(First_Flight AS INT) / 10) * 10
ORDER BY Country, Decade;

-- Stand nach den Migrationen von 26.4: Finanzkäufe, Teillieferungen und die Flyway-Historie

UPDATE kaufvertrag SET finanzkauf = true WHERE kv_id IN (19, 23, 31, 32, 47, 50, 51, 52, 54, 57, 61, 72, 80, 98, 102, 103, 112, 114, 115, 116, 120, 125, 126, 129, 133, 137, 140);

INSERT INTO lieferteil (lt_id, kv_id, teil_nr, wunsch_kw, status) VALUES
  (1, 3, 1, '2026-42', 'AUSGELIEFERT'),
  (2, 3, 2, '2026-45', 'ERFASST'),
  (3, 4, 1, '2026-40', 'AUSGELIEFERT'),
  (4, 4, 2, '2026-43', 'ERFASST'),
  (5, 9, 1, '2026-31', 'AUSGELIEFERT'),
  (6, 9, 2, '2026-34', 'ERFASST'),
  (7, 24, 1, '2026-42', 'ERFASST'),
  (8, 24, 2, '2026-45', 'ERFASST'),
  (9, 30, 1, '2026-17', 'AUSGELIEFERT'),
  (10, 30, 2, '2026-20', 'ERFASST'),
  (11, 33, 1, '2026-08', 'AUSGELIEFERT'),
  (12, 33, 2, '2026-11', 'ERFASST'),
  (13, 34, 1, '2026-27', 'AUSGELIEFERT'),
  (14, 34, 2, '2026-30', 'ERFASST'),
  (15, 39, 1, '2026-36', 'AUSGELIEFERT'),
  (16, 39, 2, '2026-39', 'ERFASST');

UPDATE kv_position SET lt_id = 1 WHERE kv_id = 3 AND pos_nr = 1;
UPDATE kv_position SET lt_id = 2 WHERE kv_id = 3 AND pos_nr > 1;
UPDATE kv_position SET lt_id = 3 WHERE kv_id = 4 AND pos_nr = 1;
UPDATE kv_position SET lt_id = 4 WHERE kv_id = 4 AND pos_nr > 1;
UPDATE kv_position SET lt_id = 5 WHERE kv_id = 9 AND pos_nr = 1;
UPDATE kv_position SET lt_id = 6 WHERE kv_id = 9 AND pos_nr > 1;
UPDATE kv_position SET lt_id = 7 WHERE kv_id = 24 AND pos_nr = 1;
UPDATE kv_position SET lt_id = 8 WHERE kv_id = 24 AND pos_nr > 1;
UPDATE kv_position SET lt_id = 9 WHERE kv_id = 30 AND pos_nr = 1;
UPDATE kv_position SET lt_id = 10 WHERE kv_id = 30 AND pos_nr > 1;
UPDATE kv_position SET lt_id = 11 WHERE kv_id = 33 AND pos_nr = 1;
UPDATE kv_position SET lt_id = 12 WHERE kv_id = 33 AND pos_nr > 1;
UPDATE kv_position SET lt_id = 13 WHERE kv_id = 34 AND pos_nr = 1;
UPDATE kv_position SET lt_id = 14 WHERE kv_id = 34 AND pos_nr > 1;
UPDATE kv_position SET lt_id = 15 WHERE kv_id = 39 AND pos_nr = 1;
UPDATE kv_position SET lt_id = 16 WHERE kv_id = 39 AND pos_nr > 1;

UPDATE tour_stopp SET lt_id = 1 WHERE stopp_id = 1;
UPDATE tour_stopp SET lt_id = 3 WHERE stopp_id = 2;
UPDATE tour_stopp SET lt_id = 5 WHERE stopp_id = 3;
UPDATE tour_stopp SET lt_id = 9 WHERE stopp_id = 5;
UPDATE tour_stopp SET lt_id = 11 WHERE stopp_id = 7;
UPDATE tour_stopp SET lt_id = 13 WHERE stopp_id = 8;
UPDATE tour_stopp SET lt_id = 15 WHERE stopp_id = 9;

SELECT setval(pg_get_serial_sequence('lieferteil', 'lt_id'), (SELECT max(lt_id) FROM lieferteil));
SELECT setval(pg_get_serial_sequence('kassenbeleg', 'beleg_id'), (SELECT max(beleg_id) FROM kassenbeleg));

INSERT INTO rechnung (rechnungs_nr, kv_id, belegart, betrag, belegdatum)
SELECT 'TR-26' || (2000 + l.lt_id), l.kv_id, 'TR', round(sum(p.menge * p.einzelpreis), 2), k.wunschtermin
FROM lieferteil l
JOIN kaufvertrag k ON k.kv_id = l.kv_id
JOIN kv_position p ON p.lt_id = l.lt_id
WHERE l.status = 'AUSGELIEFERT'
GROUP BY l.lt_id, l.kv_id, k.wunschtermin;

INSERT INTO flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) VALUES
  (1, '26.2', '<< Flyway Baseline >>', 'BASELINE', '<< Flyway Baseline >>', NULL, 'flyway', '2026-04-14 06:12:00', 0, true),
  (2, '26.3.004', 'idx kvp artikel', 'SQL', 'V26_3_004__idx_kvp_artikel.sql', 105892889, 'flyway', '2026-06-02 05:30:00', 234, true),
  (3, '26.3.009', 'kv finanzkauf', 'SQL', 'V26_3_009__kv_finanzkauf.sql', 526356710, 'flyway', '2026-06-03 05:30:00', 256, true),
  (4, '26.4.012', 'lieferteil', 'SQL', 'V26_4_012__lieferteil.sql', 1921613089, 'flyway', '2026-09-10 05:30:00', 457, true),
  (5, '26.4.015', 'kassenbeleg partition', 'SQL', 'V26_4_015__kassenbeleg_partition.sql', -153819078, 'flyway', '2026-09-11 05:30:00', 368, true),
  (6, '26.4.016', 'kassenbeleg alle', 'SQL', 'V26_4_016__kassenbeleg_alle.sql', -572076522, 'flyway', '2026-09-12 05:30:00', 397, true);

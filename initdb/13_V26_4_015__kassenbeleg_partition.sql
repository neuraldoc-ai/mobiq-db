-- Kassenbelege nach Belegjahr partitionieren (MOB-4790)
ALTER TABLE kassenbeleg RENAME TO kassenbeleg_alt;

CREATE TABLE kassenbeleg (LIKE kassenbeleg_alt INCLUDING ALL) PARTITION BY RANGE (belegdatum);

DO $$
DECLARE jahr int;
BEGIN
  FOR jahr IN 2014..2027 LOOP
    EXECUTE format('CREATE TABLE kassenbeleg_%s PARTITION OF kassenbeleg FOR VALUES FROM (%L) TO (%L)',
                   jahr, make_date(jahr, 1, 1), make_date(jahr + 1, 1, 1));
  END LOOP;
END $$;

INSERT INTO kassenbeleg SELECT * FROM kassenbeleg_alt;
DROP TABLE kassenbeleg_alt;

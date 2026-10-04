-- Teillieferung (MOB-4812)
CREATE TABLE lieferteil (
  lt_id        bigserial PRIMARY KEY,
  kv_id        bigint    NOT NULL REFERENCES kaufvertrag (kv_id),
  teil_nr      smallint  NOT NULL,
  wunsch_kw    char(7),
  status       varchar(20) NOT NULL DEFAULT 'ERFASST',
  UNIQUE (kv_id, teil_nr)
);

ALTER TABLE kv_position ADD COLUMN lt_id bigint REFERENCES lieferteil (lt_id);
ALTER TABLE tour_stopp  ADD COLUMN lt_id bigint REFERENCES lieferteil (lt_id);

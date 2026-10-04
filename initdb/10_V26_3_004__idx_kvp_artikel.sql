-- Schnellere Suche nach Artikelnummer in Kaufvertragspositionen
CREATE INDEX idx_kvp_artikel ON kv_position (artikel_nr);

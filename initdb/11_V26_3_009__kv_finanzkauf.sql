-- Kennzeichen Finanzkauf (Ratenkredit über Partnerbank)
ALTER TABLE kaufvertrag ADD COLUMN finanzkauf boolean NOT NULL DEFAULT false;
